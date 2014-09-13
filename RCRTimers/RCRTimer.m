//
//  RCRTimer.m
//
//  Created by Rich Robinson on 07/09/2014.
//  Copyright (c) 2014 Rich Robinson. All rights reserved.
//

#import "RCRTimer.h"

static NSTimeInterval const IntervalOffset = 0.02;

@interface RCRTimer ()

@property (nonatomic) BOOL isRunning;
@property (nonatomic, copy) void (^block) (NSDate *firingDate);

@end

@implementation RCRTimer

- (instancetype)initWithBlock:(void (^) (NSDate *firingDate))block {
    self = [super init];
    
    if (self) {
        _isRunning = NO;
        _block = block;
        
        // Only do anything if we actually have a block of code to run
        if (_block) {
            _isRunning = YES;
            [self runTimer];
        }
    }
    
    return self;
}

+ (instancetype)timerWithBlock:(void (^) (NSDate *firingDate))block {
    return [[self alloc] initWithBlock:block];
}

- (void)dealloc {
    [self stop];
}

- (void)stop {
    // We access the ivar directly as this method is called from dealloc
    _isRunning = NO;
}

#pragma mark - Abstract methods that must be overridden by subclasses

- (NSDate *)nextFireDate {
    // Abstract implementation
    return nil;
}

#pragma mark - Abstract methods that may optionally overridden by subclasses

- (BOOL)applyOffset {
    // By default we apply the offset to each firing of the timer
    return YES;
}

#pragma mark - Private methods

- (void)runTimer {
    
    if (self.isRunning) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([self intervalUntilNextFireDate] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            self.block([NSDate date]);
      
            // We keep the timer running by repeatedly calling runTimer (until self.isRunning is no longer YES)
            [self runTimer];
        });
    }
    else {
        self.block = nil;
    }
    
}

- (NSTimeInterval)intervalUntilNextFireDate {
    NSTimeInterval interval = [[self nextFireDate] timeIntervalSinceDate:[NSDate date]];
    
    if ([self applyOffset]) {
        interval += IntervalOffset;
    }

    return interval;
}

@end
