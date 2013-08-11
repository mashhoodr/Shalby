//
//  MLSettingsViewController.h
//  Shalby
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MLBatteryMonitor.h"

@interface MLSettingsViewController : NSViewController <NSTextFieldDelegate>


@property (nonatomic, strong) MLBatteryMonitor *monitor;

@property (weak) IBOutlet NSTextField *interval;
@property (weak) IBOutlet NSTextField *upperBoundText;
@property (weak) IBOutlet NSTextField *lowerBoundText;


-(IBAction)setUpperBoundValue:(NSSlider *)sender;
-(IBAction)setLowerBoundValue:(NSSlider *)sender;
-(IBAction)exit:(NSButton *)sender;
-(IBAction)closeSettings:(NSButton *)sender;

@end
