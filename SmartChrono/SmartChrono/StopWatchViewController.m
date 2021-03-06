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
    BOOL isPaused;
    NSDateFormatter *dateFormatter;
    NSTimeInterval eleapsedTimeAtPause;
    NSTimeInterval timeInterval;
    NSTimer *chronoTimer;
    NSDate *startDate;
    NSMutableArray *dataToShow;
}
- (void)releaseOutlets;
@property(nonatomic, retain) NSDateFormatter *dateFormatter;
@end

@implementation StopWatchViewController

//Synthetise outlets
@synthesize chronoLabel;
@synthesize startButton;
@synthesize checkpointList;

@synthesize dateFormatter;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
        [dateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        eleapsedTimeAtPause = 0;
    }
    return self;
}
- (void)dealloc
{
    [self releaseOutlets];
    [dateFormatter release];
    [dataToShow release];
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
    dataToShow = [NSMutableArray arrayWithCapacity:10];
    [dataToShow retain];
     
}

- (void)releaseOutlets
{
    self.chronoLabel = nil;
    self.startButton = nil;
    self.checkpointList = nil;
}

- (void)viewDidUnload
{
    [self releaseOutlets];
    [checkpointList release];
    checkpointList = nil;
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
    timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval + eleapsedTimeAtPause];
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    chronoLabel.text = timeString;
}

- (void)updatePausedStatus
{
    NSLog(@"Paused status: %u", isPaused);
    if (!isPaused) {
        [startButton setImage:[UIImage imageNamed:@"129107-simple-red-square-icon-media-a-media27-pause-sign"] 
                     forState:UIControlStateNormal];
    }
    else {
        [startButton setImage:[UIImage imageNamed:@"129102-simple-red-square-icon-media-a-media22-arrow-forward1"] 
                     forState:UIControlStateNormal];
    }
}

- (void)stopTimer
{
    //Stop the chrono
    [chronoTimer invalidate];
    [chronoTimer release];
    chronoTimer = nil;
}

- (IBAction)onStartPressed:(UIButton *)sender
{
    //Check if the stopwatch is already started or not
    //And init global status values
    if (!isWorking) {
        isWorking = YES;
        isPaused = NO;
    }
    else {
        //If stopwatch is started hitting play button switch between play and
        //pause
        isPaused = !isPaused;
    }
    [self updatePausedStatus];
    
    //
    if (isPaused) {
        [self stopTimer];
        
        //Save the time eleapsed
        eleapsedTimeAtPause = timeInterval + eleapsedTimeAtPause;
    }
    else {
        startDate = [NSDate date];
        [startDate retain];
        chronoTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/1000.0 
                                                       target:self 
                                                     selector:@selector(updateTimer) 
                                                     userInfo:nil 
                                                      repeats:YES];
        [chronoTimer retain];
    }
}

- (IBAction)onStopPressed:(UIButton *)sender
{
    if (isWorking) {
        [self stopTimer];
        
        [startDate release];
        startDate = nil;
        
        isWorking = NO;
        isPaused = NO;
        eleapsedTimeAtPause = 0;
        [startButton setImage:[UIImage imageNamed:@"129102-simple-red-square-icon-media-a-media22-arrow-forward1"]
                     forState:UIControlStateNormal];
        
    }
    else {
        chronoLabel.text = @"00:00:00.000";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1; // 1
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataToShow count]; // 2
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; // 1
    if (cell == nil) { // 2
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [dataToShow objectAtIndex:indexPath.row]; // 3
    
    return cell;
}

-(void)addCheckpoint:(id)sender
{
//    if (!dataToShow) {
//        dataToShow = [NSMutableArray arrayWithCapacity:10];
//    }
    [dataToShow addObject:chronoLabel.text];
    [checkpointList reloadData];
}

-(void)resetCheckList:(id)sender
{
//    if (!dataToShow) {
//        dataToShow = [NSMutableArray arrayWithCapacity:10];
//    }
    [dataToShow removeAllObjects];
    [checkpointList reloadData];
}

@end
