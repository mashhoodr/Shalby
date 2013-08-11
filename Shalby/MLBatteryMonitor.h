//
//  MLBatteryMonitor.h
//  Shalby
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLBatteryMonitor : NSObject

@property (assign) NSInteger upperBound, lowerBound, interval;

-(void)reset;

@end
