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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    states = [[NSMutableArray alloc] init];
    
    [states addObject:@1];
    [states addObject:@1];
    [states addObject:@1];
    [states addObject:@1];
    
    [self.button1 setTitle:@"X" forState:UIControlStateNormal];
    [self.button2 setTitle:@"X" forState:UIControlStateNormal];
    [self.button3 setTitle:@"X" forState:UIControlStateNormal];
    [self.button4 setTitle:@"X" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButtonClick:(id)sender {
//    NSLog(@"%@", [sender currentTitle]);
//    [sender setTitle:@"X" forState:UIControlStateNormal];
    int buttonIndex = (int)((UIButton *)sender).tag;
//    NSLog(@"%d", buttonIndex);
    
//    bool buttonState = [states objectAtIndex:buttonIndex];
    NSNumber *buttonState = states[buttonIndex];
//    NSLog(@"%d %d", buttonIndex, buttonState);
    
    if ([buttonState isEqualToNumber: @1]) {
        NSLog(@"YES");
        [self.button1 setTitle:@"X" forState:UIControlStateNormal];
        [states replaceObjectAtIndex:buttonIndex withObject:@0];
    } else {
        NSLog(@"NO");
        [self.button1 setTitle:@"O" forState:UIControlStateNormal];
        [states replaceObjectAtIndex:buttonIndex withObject:@1];
    }
}

@end
