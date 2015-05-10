//
//  ViewController.m
//  MidiHack2015
//
//  Created by Ashok Fernandez on 5/05/15.
//  Copyright (c) 2015 Ashok Fernandez. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AudioEngine.h"

@interface ViewController ()

@property AudioEngine *audioEngine;

@end

@implementation ViewController


-(IBAction)showMessage:(id)sender {
//    NSLog(@"Hello");
//
//    NSURL *file = [[NSBundle mainBundle] URLForResource:@"synth" withExtension:@"caf"];
//    self.loop = [AEAudioFilePlayer audioFilePlayerWithURL:file
//                                          audioController: audioController
//                                                    error:NULL];
    NSArray *track1Pattern = [NSArray arrayWithObjects: @1, @1, @1, @1, @1, @1, @1, @1, nil];
    NSArray *track2Pattern = [NSArray arrayWithObjects: @1, @0, @0, @0, @0, @1, @1, @0, nil];
    NSArray *track3Pattern = [NSArray arrayWithObjects: @0, @0, @1, @1, @0, @0, @0, @0, nil];
    [self.audioEngine updatePattern:[NSArray arrayWithObjects:track1Pattern, track2Pattern, track3Pattern, nil]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    self.audioEngine = [AudioEngine create];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
