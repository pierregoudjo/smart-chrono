//
//  ViewController.h
//  SmartChrono
//
//  Created by Pierre GOUDJO on 21/04/12.
//  Copyright (c) 2012 UNS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopWatchViewController : UIViewController {
    @private
    IBOutlet UILabel *chronoLabel;
    IBOutlet UIButton *startButton;
    NSTimer *chronoTimer;
    NSDate *startDate;
}

@property(nonatomic, retain) IBOutlet UILabel *chronoLabel;
@property(nonatomic, retain) IBOutlet UIButton *startButton;
- (IBAction)onStartPressed:(UIButton *)sender;
- (IBAction)onStopPressed:(UIButton *)sender;

@end
