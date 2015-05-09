//
//  AudioEngine.m
//  MidiHack2015
//
//  Created by Ashok Fernandez on 9/05/15.
//  Copyright (c) 2015 Ashok Fernandez. All rights reserved.
//

@import Foundation;
#import "AudioEngine.h"
#import "AudioSamplePlayer.h"
#import <TheAmazingAudioEngine/TheAmazingAudioEngine.h>

#define NUM_CHANNELS 3
#define NUM_STEPS 4

@interface AudioEngine ()
@property (nonatomic) AEAudioController *audioController;
@property (nonatomic) NSArray *channels;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSUInteger step;
@property (nonatomic) NSArray *pattern;
@end

@implementation AudioEngine

+(id)create {
    
    AudioEngine *engine = [[self alloc] init];

    engine->_audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleavedFloatStereoAudioDescription]];
    
    // Initialise tracks
    AudioSamplePlayer *track1 = [AudioSamplePlayer audioFilePlayerWithURL:[[NSBundle mainBundle] URLForResource:@"Kick" withExtension:@"caf"]
                                            audioController: engine->_audioController
                                                      error:NULL];

    AudioSamplePlayer *track2 = [AudioSamplePlayer audioFilePlayerWithURL:[[NSBundle mainBundle] URLForResource:@"Snare" withExtension:@"caf"]
                                                          audioController: engine->_audioController
                                                                    error:NULL];

    AudioSamplePlayer *track3 = [AudioSamplePlayer audioFilePlayerWithURL:[[NSBundle mainBundle] URLForResource:@"Hat" withExtension:@"caf"]
                                                          audioController: engine->_audioController
                                                                    error:NULL];

    
    // Save channels to object
    engine->_channels = [NSArray arrayWithObjects:track1, track2, track3, nil];
    
    // Add channels to main audio controller
    [engine->_audioController addChannels: engine->_channels];

    // Start playback
    NSError *error = nil;
    if ( ! [engine->_audioController start:&error])
    {
        NSLog(@"%@", error);
        return nil;
    }
    
    // Initialise the step value and timer
    engine->_step = 0;
    
    engine->_timer = [NSTimer scheduledTimerWithTimeInterval:0.3
                                     target:engine
                                   selector:@selector(incrementStep)
                                   userInfo:nil
                                    repeats:YES];
    
    // Hardcode a pattern to play
    NSArray *kickPattern = [NSArray arrayWithObjects: @1, @0, @0, @0, nil];
    NSArray *snarePattern = [NSArray arrayWithObjects: @0, @0, @1, @0, nil];
    NSArray *hatPattern = [NSArray arrayWithObjects: @0, @1, @1, @1, nil];
    
    engine->_pattern = [NSArray arrayWithObjects: kickPattern, snarePattern, hatPattern, nil];
    
    return engine;

}

-(void)incrementStep {

    AudioSamplePlayer *channel;
    NSArray *pattern;

    for (int i=0; i<NUM_CHANNELS; i++) {
        channel = self.channels[i];
        pattern = self.pattern[i];
        
        if ([pattern[self.step] isEqualToNumber: @1]) {
            [channel play];
        }
    }

    self.step += 1;
    if(self.step >= NUM_STEPS) {
        self.step = 0;
    }
}


@end
