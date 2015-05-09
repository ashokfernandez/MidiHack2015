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
    
    UIImage *buttonImage = [UIImage imageNamed:@"play.png"];
    [buttons[0] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[1] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[2] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[3] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    // Remove text values that were set on buttons since they're only set for debugging purposes
    [self.button1 setTitle:@"" forState:UIControlStateNormal];
    [self.button2 setTitle:@"" forState:UIControlStateNormal];
    [self.button3 setTitle:@"" forState:UIControlStateNormal];
    [self.button4 setTitle:@"" forState:UIControlStateNormal];
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
        UIImage *buttonImage = [UIImage imageNamed:@"play.png"];
        [buttons[buttonIndex] setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [states replaceObjectAtIndex:buttonIndex withObject:@0];
    } else {
        UIImage *buttonImage = [UIImage imageNamed:@"ellipses.png"];
        [buttons[buttonIndex] setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [states replaceObjectAtIndex:buttonIndex withObject:@1];
    }
    
    
    
    NSLog(@"state: %@", states);
}

@end
