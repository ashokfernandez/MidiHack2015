//
//  ViewController.m
//  MidiHack2015
//
//  Created by Ashok Fernandez on 5/05/15.
//  Copyright (c) 2015 Ashok Fernandez. All rights reserved.
//

#import "AudioEngine.h"
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
    
    // ROW 1
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    
    // ROW 2
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    
    // ROW 3
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    [states addObject:@0];
    
    // ROW 1
    [buttons addObject:self.button1];
    [buttons addObject:self.button2];
    [buttons addObject:self.button3];
    [buttons addObject:self.button4];
    [buttons addObject:self.button5];
    [buttons addObject:self.button6];
    [buttons addObject:self.button7];
    [buttons addObject:self.button8];
    
    // ROW 2
    [buttons addObject:self.button9];
    [buttons addObject:self.button10];
    [buttons addObject:self.button11];
    [buttons addObject:self.button12];
    [buttons addObject:self.button13];
    [buttons addObject:self.button14];
    [buttons addObject:self.button15];
    [buttons addObject:self.button16];
    
    // ROW 3
    [buttons addObject:self.button17];
    [buttons addObject:self.button18];
    [buttons addObject:self.button19];
    [buttons addObject:self.button20];
    [buttons addObject:self.button21];
    [buttons addObject:self.button22];
    [buttons addObject:self.button23];
    [buttons addObject:self.button24];
    
    UIImage *buttonImage = [UIImage imageNamed:@"play.png"];
    
    // ROW 1
    [buttons[0] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[1] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[2] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[3] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[4] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[5] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[6] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[7] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    // ROW 2
    [buttons[8] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[9] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[10] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[11] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[12] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[13] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[14] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[15] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    // ROW 3
    [buttons[16] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[17] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[18] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[19] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[20] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[21] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[22] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttons[23] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    // Remove text values that were set on buttons since they're only set for debugging purposes
    
    // ROW 1
    [self.button1 setTitle:@"" forState:UIControlStateNormal];
    [self.button2 setTitle:@"" forState:UIControlStateNormal];
    [self.button3 setTitle:@"" forState:UIControlStateNormal];
    [self.button4 setTitle:@"" forState:UIControlStateNormal];
    [self.button5 setTitle:@"" forState:UIControlStateNormal];
    [self.button6 setTitle:@"" forState:UIControlStateNormal];
    [self.button7 setTitle:@"" forState:UIControlStateNormal];
    [self.button8 setTitle:@"" forState:UIControlStateNormal];
    
    // ROW 2
    [self.button9 setTitle:@"" forState:UIControlStateNormal];
    [self.button10 setTitle:@"" forState:UIControlStateNormal];
    [self.button11 setTitle:@"" forState:UIControlStateNormal];
    [self.button12 setTitle:@"" forState:UIControlStateNormal];
    [self.button13 setTitle:@"" forState:UIControlStateNormal];
    [self.button14 setTitle:@"" forState:UIControlStateNormal];
    [self.button15 setTitle:@"" forState:UIControlStateNormal];
    [self.button16 setTitle:@"" forState:UIControlStateNormal];
    
    // ROW 3
    [self.button17 setTitle:@"" forState:UIControlStateNormal];
    [self.button18 setTitle:@"" forState:UIControlStateNormal];
    [self.button19 setTitle:@"" forState:UIControlStateNormal];
    [self.button20 setTitle:@"" forState:UIControlStateNormal];
    [self.button21 setTitle:@"" forState:UIControlStateNormal];
    [self.button22 setTitle:@"" forState:UIControlStateNormal];
    [self.button23 setTitle:@"" forState:UIControlStateNormal];
    [self.button24 setTitle:@"" forState:UIControlStateNormal];
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
