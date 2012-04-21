//
//  ViewController.m
//  SmartChrono
//
//  Created by Pierre GOUDJO on 21/04/12.
//  Copyright (c) 2012 UNS. All rights reserved.
//

#import "StopWatchViewController.h"

@interface StopWatchViewController ()
- (void)releaseOutlets;
@end

@implementation StopWatchViewController

@synthesize chronoLabel;

- (void)dealloc
{
    [self releaseOutlets];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [chronoLabel setFont: [UIFont fontWithName:@"Crystal" size:70]]; 
}

- (void)releaseOutlets
{
    self.chronoLabel = nil;
}

- (void)viewDidUnload
{
    [self releaseOutlets];
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)onStartPressed:(UIButton *)sender {
}

- (IBAction)onStopPressed:(UIButton *)sender {
}
@end
