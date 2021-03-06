//
//  MLSettingsViewController.m
//  Shalby
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import "MLSettingsViewController.h"
#import "MLAppDelegate.h"
#import "MLConstants.h"

@interface MLSettingsViewController ()

@end

@implementation MLSettingsViewController {
    NSUserDefaults *defaults;
}

-(void)awakeFromNib {
    defaults = [NSUserDefaults standardUserDefaults];
    self.monitor = [[MLBatteryMonitor alloc] init];
    // set view from saved values
    [self.intervalSlider setIntegerValue:self.monitor.interval];
    [self.upperBoundSlider setIntegerValue:self.monitor.upperBound];
    [self.lowerBoundSlider setIntegerValue:self.monitor.lowerBound];
    [self setUpperBoundValue:self.upperBoundSlider];
    [self setLowerBoundValue:self.lowerBoundSlider];
    
}

#pragma mark - IBActions

-(IBAction)exit:(NSButton *)sender {
    [defaults synchronize];
    [[NSApplication sharedApplication] terminate:self];
}

-(void)closeSettings:(NSButton *)sender {
    [defaults synchronize];
    MLAppDelegate *delegate = [[NSApplication sharedApplication] delegate];
    [delegate.window close];
}

-(IBAction)setUpperBoundValue:(NSSlider *)sender {
    [self.upperBoundText setStringValue:[NSString stringWithFormat:@"Set upper level at %d%%",sender.intValue]];
    [defaults setInteger:[sender integerValue] forKey:keyUpperBound];
    self.monitor.upperBound = [sender integerValue];
    
}

-(IBAction)setLowerBoundValue:(NSSlider *)sender {
    [self.lowerBoundText setStringValue:[NSString stringWithFormat:@"Set upper level at %d%%",sender.intValue]];
    [defaults setInteger:[sender integerValue] forKey:keyLowerBound];
    self.monitor.lowerBound = [sender integerValue];
}

-(IBAction)setIntervalValue:(NSSlider *)sender {
    NSInteger value = [sender integerValue];
    [self.intervalText setStringValue:[NSString stringWithFormat:@"Check battery status every %ld mins", value]];
    [defaults setInteger:value forKey:keyInterval];
    self.monitor.interval = value;
    [self.monitor reset];
}


@end
