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
}

- (id)init
{
    self = [super init];
    if (self) {
        NSInteger defaultsInterval = [[NSUserDefaults standardUserDefaults] integerForKey:keyInterval];
        timer = [NSTimer timerWithTimeInterval:defaultsInterval target:self selector:@selector(check) userInfo:nil repeats:YES];
    }
    return self;
}


-(void)check {
    float charge = [MLBatteryInfo currentCharge] * 100;
    NSInteger upperBound = [[NSUserDefaults standardUserDefaults] integerForKey:keyUpperBound];
    NSInteger lowerBound = [[NSUserDefaults standardUserDefaults] integerForKey:keyLowerBound];
    
    if(charge > upperBound) {
        NSLog(@"Please disconnect.");
    }
    else if(charge < lowerBound)
        NSLog(@"Please reconnect.");
    
}

@end
