//
//  AudioEngine.m
//  MidiHack2015
//
//  Created by Ashok Fernandez on 9/05/15.
//  Copyright (c) 2015 Ashok Fernandez. All rights reserved.
//

#import "AudioEngine.h"
#import "AudioSamplePlayer.h"
#import <TheAmazingAudioEngine/TheAmazingAudioEngine.h>

@interface AudioEngine ()
@property (nonatomic) AEAudioController *audioController;
@property     AudioSamplePlayer *track1;
//@property (nonatomic) NSArray *channels;
//@property (nonatomic) AEAudioUnitFilter *pulseReverb;
//@property (nonatomic) AEAudioUnitFilter *boopReverb;
//@property (nonatomic) BOOL *channelActivity;
@end

@implementation AudioEngine

-(BOOL)setup {
    self.audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleavedFloatStereoAudioDescription]];
    
    // Initialise tracks
    NSError *errorTrack1 = nil;
    self.track1 =
    [AudioSamplePlayer audioFilePlayerWithURL:
     [[NSBundle mainBundle] URLForResource:@"synth" withExtension:@"caf"]
                              audioController: self.audioController
                                        error:&errorTrack1];

//    NSError *errorTrack2 = nil;
//    [AEAudioFilePlayer audioFilePlayerWithURL:
//     [[NSBundle mainBundle] URLForResource:@"Track 2" withExtension:@"m4a"]
//                              audioController: self.audioController
//                                        error:&errorTrack2];
    
//    NSLog(@"%@", error);
    
    // Set to loop mode
//    self.track1.loop = YES;
//    track2.loop = YES;
    
    // Add channels
    [self.audioController addChannels:[NSArray arrayWithObjects:self.track1, nil]];

    NSError *error = nil;
    if ( ! [self.audioController start:&error])
    {
        NSLog(@"%@", error);
        return NO;
    }
    
    return YES;

}

- (BOOL)start
{
    [self.track1 replay];
    return YES;
}

@end
