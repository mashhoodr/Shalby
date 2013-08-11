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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

-(IBAction)exit:(NSButton *)sender {
    [[NSApplication sharedApplication] terminate:self];
}

-(void)closeSettings:(NSButton *)sender {
    MLAppDelegate *delegate = [[NSApplication sharedApplication] delegate];
    [delegate.window close];
}

-(IBAction)setUpperBoundValue:(NSSlider *)sender {
    [self.upperBoundText setStringValue:[NSString stringWithFormat:@"Set upper level at %d%%",sender.intValue]];
    [defaults setInteger:[sender integerValue] forKey:keyUpperBound];
}

-(IBAction)setLowerBoundValue:(NSSlider *)sender {
    [self.lowerBoundText setStringValue:[NSString stringWithFormat:@"Set upper level at %d%%",sender.intValue]];
    [defaults setInteger:[sender integerValue] forKey:keyLowerBound];
}

-(void)controlTextDidChange:(NSNotification *)obj {
    NSTextField *field = [obj object];
    int value = [field intValue];
    if(value == 0) [field setStringValue:@"0"];
    [defaults setInteger:[field integerValue] forKey:keyInterval];
}


@end
