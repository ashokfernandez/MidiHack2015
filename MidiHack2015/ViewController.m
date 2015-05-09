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
        self.audioEngine = [AudioEngine create];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
//    self.audioEngine = [[AudioEngine alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
