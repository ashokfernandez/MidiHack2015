//
//  AudioSample.m
//  MidiHack2015
//
//  Created by Ashok Fernandez on 9/05/15.
//  Copyright (c) 2015 Ashok Fernandez. All rights reserved.
//

#import "AudioSamplePlayer.h"
#import "AEAudioFileLoaderOperation.h"
#import <libkern/OSAtomic.h>

#define checkStatus(status) \
if ( (status) != noErr ) {\
NSLog(@"Error: %ld -> %s:%d", (status), __FILE__, __LINE__);\
}

@interface AudioSamplePlayer () {
    AudioBufferList              *_audio;
    UInt32                        _lengthInFrames;
    AudioStreamBasicDescription   _audioDescription;
    volatile int32_t              _playhead;
}
@property (nonatomic, strong, readwrite) NSURL *url;
@end

@implementation AudioSamplePlayer
@synthesize url = _url, loop=_loop, volume=_volume, pan=_pan, channelIsPlaying=_channelIsPlaying, channelIsMuted=_channelIsMuted, removeUponFinish=_removeUponFinish, completionBlock = _completionBlock, startLoopBlock = _startLoopBlock;
@dynamic duration, currentTime;

+ (id)audioFilePlayerWithURL:(NSURL*)url audioController:(AEAudioController *)audioController error:(NSError **)error {
    
    AudioSamplePlayer *player = [[self alloc] init];
    player->_volume = 1.0;
    player->_channelIsPlaying = YES;
    player->_audioDescription = audioController.audioDescription;
    player.url = url;
    
    AEAudioFileLoaderOperation *operation = [[AEAudioFileLoaderOperation alloc] initWithFileURL:url targetAudioDescription:player->_audioDescription];
    [operation start];
    
    if ( operation.error ) {
        if ( error ) {
            *error = operation.error;
        }
        return nil;
    }
    
    player->_audio = operation.bufferList;
    player->_lengthInFrames = operation.lengthInFrames;
    player->_playhead = operation.lengthInFrames;
    
    
    return player;
}

- (void)dealloc {
    if ( _audio ) {
        for ( int i=0; i<_audio->mNumberBuffers; i++ ) {
            free(_audio->mBuffers[i].mData);
        }
        free(_audio);
    }
}

-(NSTimeInterval)duration {
    return (double)_lengthInFrames / (double)_audioDescription.mSampleRate;
}

-(NSTimeInterval)currentTime {
    if (_lengthInFrames == 0) return 0.0;
    else return ((double)_playhead / (double)_lengthInFrames) * [self duration];
}

-(void)setCurrentTime:(NSTimeInterval)currentTime {
    if (_lengthInFrames == 0) return;
    _playhead = (int32_t)((currentTime / [self duration]) * _lengthInFrames) % _lengthInFrames;
}

-(void)play{
    _playhead = (int32_t)((0) * _lengthInFrames) % _lengthInFrames;
    _channelIsPlaying = YES;
}

static void notifyLoopRestart(AEAudioController *audioController, void *userInfo, int length) {
    AudioSamplePlayer *THIS = (__bridge AudioSamplePlayer*)*(void**)userInfo;
    
    if ( THIS.startLoopBlock ) THIS.startLoopBlock();
}

static void notifyPlaybackStopped(AEAudioController *audioController, void *userInfo, int length) {
    AudioSamplePlayer *THIS = (__bridge AudioSamplePlayer*)*(void**)userInfo;
    
    if ( THIS.completionBlock ) THIS.completionBlock();
}


static OSStatus renderCallback(__unsafe_unretained AudioSamplePlayer *THIS, __unsafe_unretained AEAudioController *audioController, const AudioTimeStamp *time, UInt32 frames, AudioBufferList *audio) {
    int32_t playhead = THIS->_playhead;
    int32_t originalPlayhead = playhead;
    
    if ( !THIS->_channelIsPlaying ) return noErr;
    
    if ( !THIS->_loop && playhead == THIS->_lengthInFrames ) {
        // Notify main thread that playback has finished
        AEAudioControllerSendAsynchronousMessageToMainThread(audioController, notifyPlaybackStopped, &THIS, sizeof(AudioSamplePlayer*));
        THIS->_channelIsPlaying = NO;
        return noErr;
    }
    
    // Get pointers to each buffer that we can advance
    char *audioPtrs[audio->mNumberBuffers];
    for ( int i=0; i<audio->mNumberBuffers; i++ ) {
        audioPtrs[i] = audio->mBuffers[i].mData;
    }
    
    int bytesPerFrame = THIS->_audioDescription.mBytesPerFrame;
    int remainingFrames = frames;
    
    // Copy audio in contiguous chunks, wrapping around if we're looping
    while ( remainingFrames > 0 ) {
        // The number of frames left before the end of the audio
        int framesToCopy = MIN(remainingFrames, THIS->_lengthInFrames - playhead);
        
        // Fill each buffer with the audio
        for ( int i=0; i<audio->mNumberBuffers; i++ ) {
            memcpy(audioPtrs[i], ((char*)THIS->_audio->mBuffers[i].mData) + playhead * bytesPerFrame, framesToCopy * bytesPerFrame);
            
            // Advance the output buffers
            audioPtrs[i] += framesToCopy * bytesPerFrame;
        }
        
        // Advance playhead
        remainingFrames -= framesToCopy;
        playhead += framesToCopy;
        
        if ( playhead >= THIS->_lengthInFrames ) {
            // Reached the end of the audio - either loop, or stop
            if ( THIS->_loop ) {
                playhead = 0;
                if ( THIS->_startLoopBlock ) {
                    // Notify main thread that the loop playback has restarted
                    AEAudioControllerSendAsynchronousMessageToMainThread(audioController, notifyLoopRestart, &THIS, sizeof(AudioSamplePlayer*));
                }
            } else {
                // Notify main thread that playback has finished
                AEAudioControllerSendAsynchronousMessageToMainThread(audioController, notifyPlaybackStopped, &THIS, sizeof(AudioSamplePlayer*));
                THIS->_channelIsPlaying = NO;
                break;
            }
        }
    }
    
    OSAtomicCompareAndSwap32(originalPlayhead, playhead, &THIS->_playhead);
    
    return noErr;
}

-(AEAudioControllerRenderCallback)renderCallback {
    return &renderCallback;
}

@end