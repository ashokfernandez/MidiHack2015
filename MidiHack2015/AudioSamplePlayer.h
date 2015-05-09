//
//  AudioSample.h
//  MidiHack2015
//
//  Created by Ashok Fernandez on 9/05/15.
//  Copyright (c) 2015 Ashok Fernandez. All rights reserved.
//


#ifdef __cplusplus
extern "C" {
#endif
    
#import <Foundation/Foundation.h>
#import "AEAudioController.h"
    
    /*!
     * Audio file player
     *
     *  This class allows you to play audio files, either as one-off samples, or looped.
     *  It will play any audio file format supported by iOS.
     *
     *  To use, create an instance, then add it to the audio controller.
     */
    @interface AudioSamplePlayer : NSObject <AEAudioPlayable>

/*!
 * Create a new player instance
 *
 * @param url               URL to the file to load
 * @param audioController   The audio controller
 * @param error             If not NULL, the error on output
 * @return The audio player, ready to be @link AEAudioController::addChannels: added @endlink to the audio controller.
 */
+ (id)audioFilePlayerWithURL:(NSURL*)url audioController:(AEAudioController*)audioController error:(NSError**)error;

@property (nonatomic, strong, readonly) NSURL *url;         //!< Original media URL
@property (nonatomic, readonly) NSTimeInterval duration;    //!< Length of audio, in seconds
@property (nonatomic, assign) NSTimeInterval currentTime;   //!< Current playback position, in seconds
@property (nonatomic, readwrite) BOOL loop;                 //!< Whether to loop this track
@property (nonatomic, readwrite) float volume;              //!< Track volume
@property (nonatomic, readwrite) float pan;                 //!< Track pan
@property (nonatomic, readwrite) BOOL channelIsPlaying;     //!< Whether the track is playing
@property (nonatomic, readwrite) BOOL channelIsMuted;       //!< Whether the track is muted
@property (nonatomic, readwrite) BOOL removeUponFinish;     //!< Whether the track automatically removes itself from the audio controller after playback completes
@property (nonatomic, copy) void(^completionBlock)();       //!< A block to be called when playback finishes
@property (nonatomic, copy) void(^startLoopBlock)();        //!< A block to be called when the loop restarts in loop mode

-(void)replay; // Starts the clip again
@end
    
#ifdef __cplusplus
}
#endif