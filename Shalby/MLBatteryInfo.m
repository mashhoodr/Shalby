//
//  MLBatteryInfo.m
//  Shalby
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import "MLBatteryInfo.h"
#import "NSString+Contains.h"

@implementation MLBatteryInfo

+(float)currentCapacity {
    NSString *batteryInfo = [self fetchBatteryInformation];
    if([batteryInfo contains:@"CurrentCapacity"])
        return [[self captureStringUsing:@"(?<=CurrentCapacity\" = )[0-9]+"
                                             inText:batteryInfo] floatValue];
    return 0;
}

+(float)maxCapacity {
    NSString *batteryInfo = [self fetchBatteryInformation];
    if([batteryInfo contains:@"DesignCapacity"])
        return [[self captureStringUsing:@"(?<=DesignCapacity\" = )[0-9]+"
                                         inText:batteryInfo] floatValue];

    return 1;
}

+(BOOL)isCharging {
    NSString *chargingInfo = [self fetchChargingInformation];
    if([chargingInfo contains:@"Yes"])
        return YES;
    
    return NO;
}

+(float)currentCharge {
    return [self currentCapacity] / [self maxCapacity];
}

#pragma mark - Private Methods

+(NSString *)fetchChargingInformation {
    return [self runBashScript:@"ioreg -wO -l | grep IsCharging"];
}

+(NSString *)fetchBatteryInformation {
    return [self runBashScript:@"ioreg -wO -l | grep Capacity"];
}


+(NSString *)runBashScript:(NSString *)command {
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/bash"];
    [task setArguments: [@[@"-c"] arrayByAddingObject:command]];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    return [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
}

+(NSString *)captureStringUsing:(NSString *)pattern inText:(NSString *)response {
    NSRegularExpression *regexForTag = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                 options:NSRegularExpressionDotMatchesLineSeparators
                                                                                   error:nil];
    NSArray *temp = [regexForTag matchesInString:response options:NSMatchingReportCompletion
                                           range:NSMakeRange(0, [response length])];
    
    if(temp.count <= 0)
        return @"";
    
    NSTextCheckingResult *r = [temp lastObject];
    return [response substringWithRange:[r rangeAtIndex:0]];
}

@end
