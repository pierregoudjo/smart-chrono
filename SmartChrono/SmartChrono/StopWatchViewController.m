//
//  ViewController.m
//  SmartChrono
//
//  Created by Pierre GOUDJO on 21/04/12.
//  Copyright (c) 2012 UNS. All rights reserved.
//

#import "StopWatchViewController.h"

@interface StopWatchViewController () {
    BOOL isWorking;
    NSDateFormatter *dateFormatter;
}
- (void)releaseOutlets;
@property(nonatomic, retain) NSDateFormatter *dateFormatter;
@end

@implementation StopWatchViewController

@synthesize chronoLabel;

@synthesize dateFormatter;


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
        [dateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    }
    return self;
}
- (void)dealloc
{
    [self releaseOutlets];
    [dateFormatter release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

        [chronoLabel setFont: [UIFont fontWithName:@"Crystal" size:55]];    
    } 
    else {

        [chronoLabel setFont: [UIFont fontWithName:@"Crystal" size:116]];    
    }
     
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

//Helper method that update StopWatcher label
- (void)updateTimer
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    chronoLabel.text = timeString;
}

- (IBAction)onStartPressed:(UIButton *)sender
{
    if (!isWorking) {
        startDate = [NSDate date];
        [startDate retain];
        isWorking = YES;
    }
    
    
    if (!chronoTimer) {
        chronoTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 
                                                       target:self 
                                                     selector:@selector(updateTimer) 
                                                     userInfo:nil 
                                                      repeats:YES];
        [chronoTimer retain];
    }  
}

- (IBAction)onStopPressed:(UIButton *)sender
{
    [chronoTimer invalidate];
    [chronoTimer release];
    [startDate release];
    startDate = nil;
    chronoTimer = nil;
    isWorking = NO;
    
}

@end
