//
//  ViewController.m
//  MidiHack2015
//
//  Created by Ashok Fernandez on 5/05/15.
//  Copyright (c) 2015 Ashok Fernandez. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.button1 setTitle:@"1" forState:UIControlStateNormal];
    [self.button2 setTitle:@"2" forState:UIControlStateNormal];
    [self.button3 setTitle:@"3" forState:UIControlStateNormal];
    [self.button4 setTitle:@"4" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButtonClick:(id)sender {
    NSLog(@"%@", [sender currentTitle]);
    [sender setTitle:@"X" forState:UIControlStateNormal];
}

@end
