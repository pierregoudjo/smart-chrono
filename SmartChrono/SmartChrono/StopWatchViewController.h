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
    NSTimer *chronoTimer;
    NSDate *startDate;
}

@property(nonatomic, retain) IBOutlet UILabel *chronoLabel;
- (IBAction)onStartPressed:(UIButton *)sender;
- (IBAction)onStopPressed:(UIButton *)sender;

@end
