//
//  ViewController.m
//  RCRTimersSample
//
//  Created by Rich Robinson on 10/09/2014.
//  Copyright (c) 2014 Rich Robinson. All rights reserved.
//

#import "ViewController.h"

#import "RCRSecondChangeTimer.h"
#import "RCRMinuteChangeTimer.h"
#import "RCRHourChangeTimer.h"

@interface ViewController ()

@property (nonatomic, strong) RCRSecondChangeTimer *secondChangeTimer;
@property (nonatomic, strong) RCRMinuteChangeTimer *minuteChangeTimer;
@property (nonatomic, strong) RCRHourChangeTimer *hourChangeTimer;

@property (nonatomic, weak) IBOutlet UITextView *logTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Output an initial welcome message
    [self logText:@"Our 3 timers will log messages below..."];
    
    // Create a dateformatter we can use to output the time below
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterNoStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    
    // Setup our timers to log some text, using some very basic indendation so that each one stands out a little:
    
    self.secondChangeTimer = [RCRSecondChangeTimer timerWithBlock:^(NSDate *firingDate) {
        [self logText:[NSString stringWithFormat:@"       - RCRSecondChangeTimer firing"]];
    }];
    
    self.minuteChangeTimer = [RCRMinuteChangeTimer timerWithBlock:^(NSDate *firingDate) {
        [self logText:[NSString stringWithFormat:@"   - RCRMinuteChangeTimer firing"]];
    }];
    
    self.hourChangeTimer = [RCRHourChangeTimer timerWithBlock:^(NSDate *firingDate) {
        [self logText:[NSString stringWithFormat:@"RCRHourChangeTimer firing"]];
    }];
}

// A simple method to log some text to our logTextView
- (void)logText:(NSString *)text
{
    NSString *dateTime = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
    
    NSString *fullLogText = [NSString stringWithFormat:@"%@\t%@\n", dateTime, text];
    
    // Ensure we update the UI from the main queue
    dispatch_async(dispatch_get_main_queue(), ^{
        self.logTextView.text = [self.logTextView.text stringByAppendingString:fullLogText];
        
        [self.logTextView scrollRangeToVisible:NSMakeRange([self.logTextView.text length], 0)];
    });
    
    // We also log the text using NSLog
    NSLog(@"%@", text);
}

@end
