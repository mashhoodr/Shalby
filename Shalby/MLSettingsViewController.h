//
//  MLSettingsViewController.h
//  Shalby
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MLBatteryMonitor.h"

@interface MLSettingsViewController : NSViewController


@property (nonatomic, strong) MLBatteryMonitor *monitor;
@property (weak) IBOutlet NSSlider *upperBoundSlider;
@property (weak) IBOutlet NSSlider *lowerBoundSlider;
@property (weak) IBOutlet NSSlider *intervalSlider;

@property (weak) IBOutlet NSTextField *intervalText;
@property (weak) IBOutlet NSTextField *upperBoundText;
@property (weak) IBOutlet NSTextField *lowerBoundText;


-(IBAction)setUpperBoundValue:(NSSlider *)sender;
-(IBAction)setLowerBoundValue:(NSSlider *)sender;
-(IBAction)setIntervalValue:(NSSlider *)sender;
-(IBAction)exit:(NSButton *)sender;
-(IBAction)closeSettings:(NSButton *)sender;

@end
