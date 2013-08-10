//
//  NSString+Contains.m
//  Testmunk
//
//  Created by Mashhood Rastgar on 2/19/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import "NSString+Contains.h"

@implementation NSString (Contains)

-(BOOL)contains:(NSString *)substring {
    NSPredicate* valtest = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", substring];
    return [valtest evaluateWithObject:self];
}

@end
