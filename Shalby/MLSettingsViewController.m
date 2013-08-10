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

@implementation MLSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
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

-(void)controlTextDidChange:(NSNotification *)obj {
    NSTextField *field = [obj object];
    int value = [field intValue];
    if(value == 0) [field setStringValue:@"0"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(field.tag == FieldTagInterval) {
        if(value > 999) [field setStringValue:@"999"];
        [defaults setInteger:[field integerValue] forKey:keyInterval];
    }
    else if (field.tag == FieldTagLowerLevel) {
        if(value > 99) [field setStringValue:@"99"];
        [defaults setInteger:[field integerValue] forKey:keyLowerBound];
    }
    else if(field.tag == FieldTagUpperLevel) {
        if(value > 99) [field setStringValue:@"99"];
        [defaults setInteger:[field integerValue] forKey:keyUpperBound];
    }
}


@end
