//
//  MLBatteryInfo.m
//  Shalby
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import "MLBatteryInfo.h"
#import "NSString+Contains.h"

/**
 {
"TimeRemaining" = 271
"AvgTimeToEmpty" = 271
"InstantTimeToEmpty" = 289
"ExternalChargeCapable" = No
"CellVoltage" = (3971,3976,3970,0)
"PermanentFailureStatus" = 0
"BatteryInvalidWakeSeconds" = 30
"AdapterInfo" = 0
"MaxCapacity" = 8112
"Voltage" = 11917
"DesignCycleCount70" = 65535
"Manufacturer" = "SMP"
"Location" = 0
"CurrentCapacity" = 6917
"LegacyBatteryInfo" = {"Amperage"=18446744073709550084,"Flags"=4,"Capacity"=8112,"Current"=6917,"Voltage"=11917,"Cycle Count"=325}
"FirmwareSerialNumber" = 1
"BatteryInstalled" = Yes
"PackReserve" = 200
"CycleCount" = 325
"DesignCapacity" = 8460
"OperationStatus" = 58435
"ManufactureDate" = 16687
"AvgTimeToFull" = 65535
"BatterySerialNumber" = "D86237200CNDNMGA3"
"PostDischargeWaitSeconds" = 120
"Temperature" = 3094
"MaxErr" = 1
"ManufacturerData" = <00000000051100031150000002443263033030370341544c031500>
"FullyCharged" = No
"InstantAmperage" = 18446744073709550178
"DeviceName" = "bq20z451"
"IOGeneralInterest" = "IOCommand is not serializable"
"Amperage" = 18446744073709550084
"IsCharging" = No
"DesignCycleCount9C" = 1000
"PostChargeWaitSeconds" = 120
"ExternalConnected" = No
 
 The following information is available in the IOReg, add the parameter in grep (to minimize the 
 NSString memory print) and extract it from the string.
 */
// a temp cache created so the class does not need to fetch the data again and again for consecutive calls
#define cacheKey @"batteryInfoCache"
#define cacheTimeout 5

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
    NSString *chargingInfo = [self fetchBatteryInformation];
    if([chargingInfo contains:@"Yes"])
        return YES;
    
    return NO;
}

+(float)currentCharge {
    return [self currentCapacity] / [self maxCapacity];
}

#pragma mark - Private Methods

+(void)resetCache {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:cacheKey];
}

+(NSString *)fetchBatteryInformation {
    
    // attempt to fetch from cache
    NSString *cache = [[NSUserDefaults standardUserDefaults] objectForKey:cacheKey];
    
    if(cache == nil) {
        cache = [self runBashScript:@"ioreg -wO -l | grep -E 'Capacity|IsCharging|Cycle'"];
        [[NSUserDefaults standardUserDefaults] setObject:cache forKey:cacheKey];
        
        // reset the cache after timeout so fresh data can be called in again.
        NSTimer *timer = [NSTimer timerWithTimeInterval:cacheTimeout
                                                 target:self
                                               selector:@selector(resetCache)
                                               userInfo:nil
                                                repeats:NO];
        
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    
    return cache;
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
