//
//  MLAppDelegate.m
//  Shalby
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import "MLAppDelegate.h"
#import "MLBatteryMonitor.h"

@implementation MLAppDelegate {
    MLBatteryMonitor *info;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    info = [[MLBatteryMonitor alloc] init];
}


// So the settings window shows when the app icon is clicked again
-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    [self.window makeKeyAndOrderFront:self];
    return NO;
}

-(BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender {
    [self.window makeKeyAndOrderFront:self];
    return NO;
}



@end
