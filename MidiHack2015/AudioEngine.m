//
//  AudioEngine.m
//  MidiHack2015
//
//  Created by Ashok Fernandez on 9/05/15.
//  Copyright (c) 2015 Ashok Fernandez. All rights reserved.
//

#import "AudioEngine.h"
#import <TheAmazingAudioEngine/TheAmazingAudioEngine.h>

@interface AudioEngine ()
@property (nonatomic) AEAudioController *audioController;
//@property (nonatomic) NSArray *channels;
//@property (nonatomic) AEAudioUnitFilter *pulseReverb;
//@property (nonatomic) AEAudioUnitFilter *boopReverb;
//@property (nonatomic) BOOL *channelActivity;
@end

@implementation AudioEngine

-(BOOL)setup {
    self.audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleavedFloatStereoAudioDescription]];
    
    // Initialise tracks
//    NSError *errorTrack1 = nil;
    AEAudioFilePlayer *track1 =
    [AEAudioFilePlayer audioFilePlayerWithURL:
     [[NSBundle mainBundle] URLForResource:@"synth" withExtension:@"caf"]
                              audioController: self.audioController
                                        error:NULL];
//
//    NSError *errorTrack2 = nil;
//    AEAudioFilePlayer *track2 =
//    [AEAudioFilePlayer audioFilePlayerWithURL:
//     [[NSBundle mainBundle] URLForResource:@"Track 2" withExtension:@"m4a"]
//                              audioController: self.audioController
//                                        error:&errorTrack2];
//    
//    NSLog(@"%@", errorTrack1);
//    NSLog(@"%@", errorTrack2);
    
    // Set to loop mode
//    track1.loop = YES;
//    track2.loop = YES;
    
    // Add channels
    [self.audioController addChannels:[NSArray arrayWithObjects:track1, nil]];

    return YES;
}

- (BOOL)start
{
    NSError *error = nil;
    if ( ! [self.audioController start:&error])
    {
        NSLog(@"%@", error);
        return NO;
    }
    
    return YES;
}

@end
