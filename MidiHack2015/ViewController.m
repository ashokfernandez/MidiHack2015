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

static NSMutableArray *states;
static NSMutableArray *buttons;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    states = [[NSMutableArray alloc] init];
    buttons = [[NSMutableArray alloc] init];
    
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    
    [buttons addObject:self.button1];
    [buttons addObject:self.button2];
    [buttons addObject:self.button3];
    [buttons addObject:self.button4];
    
//    [self.button1 setTitle:@"X" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButtonClick:(id)sender {
    int buttonIndex = (int)((UIButton *)sender).tag;
    NSNumber *buttonState = states[buttonIndex];
    NSLog(@"change: index: %d state: %@", buttonIndex, buttonState);
    
    if ([buttonState isEqualToNumber: @1]) {
        [buttons[buttonIndex] setTitle:@"X" forState:UIControlStateNormal];
        [states replaceObjectAtIndex:buttonIndex withObject:@0];
    } else {
        [buttons[buttonIndex] setTitle:@"O" forState:UIControlStateNormal];
        [states replaceObjectAtIndex:buttonIndex withObject:@1];
    }
    
    NSLog(@"state: %@", states);
}

@end
