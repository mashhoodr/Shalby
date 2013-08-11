//
//  MLBatteryMonitor.m
//  Shalby
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import "MLBatteryMonitor.h"
#import "MLConstants.h"
#import "MLBatteryInfo.h"

@implementation MLBatteryMonitor {
    NSTimer *timer;
    NSUserDefaults *defaults;
}

- (id)init
{
    self = [super init];
    if (self) {
        defaults = [NSUserDefaults standardUserDefaults];
        self.interval   = [self valueForKey:keyInterval orDefault:defaultInterval];
        self.upperBound = [self valueForKey:keyUpperBound orDefault:defaultUpperBound];
        self.lowerBound = [self valueForKey:keyLowerBound orDefault:defaultLowerBound];
        [self reset];
    }
    return self;
}


-(void)sendNotificationWithTitle:(NSString *)title {
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.subtitle = title;
    notification.actionButtonTitle = @"Dismiss";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

-(void)check:(NSTimer *)sender {
    
    float charge = [MLBatteryInfo currentCharge] * 100;
    if(charge > [self upperBound]) {
        [self sendNotificationWithTitle:@"Please disconnect your charger."];
    }
    else if(charge < [self lowerBound]) {
        [self sendNotificationWithTitle:@"Please reconnect your charger."];
    }

}

-(void)reset {
    if(timer) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer timerWithTimeInterval:([self interval] * 60) target:self selector:@selector(check:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

-(NSInteger)valueForKey:(NSString *)key orDefault:(NSInteger)defaultValue {
    NSInteger val = [defaults integerForKey:key];
    if(val == 0)
        return defaultValue;
    
    return val;
}

@end
