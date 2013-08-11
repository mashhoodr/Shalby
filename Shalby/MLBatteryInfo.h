//
//  MLBatteryInfo.h
//  Shalby
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLBatteryInfo : NSObject

+(int)cycleCount;
+(float)currentCapacity;
+(float)maxCapacity;
+(float)currentCharge;
+(BOOL)isCharging;


@end
