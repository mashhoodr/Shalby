//
//  MLBatteryMonitor.h
//  Shalby
//
// Ideology behind shallow charging can be read here:
// http://www.quora.com/iPhone/Why-is-it-better-for-your-iPhone-to-keep-battery-cycles-at-a-minimum
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLBatteryMonitor : NSObject

@property (assign) NSInteger upperBound, lowerBound, interval;

-(void)reset;

@end
