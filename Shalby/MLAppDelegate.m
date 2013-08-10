//
//  MLAppDelegate.m
//  Shalby
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import "MLAppDelegate.h"
#import "MLBatteryInfo.h"

@implementation MLAppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSLog(@"Battery charge : %f%%",[MLBatteryInfo currentCharge] * 100);
}



@end
