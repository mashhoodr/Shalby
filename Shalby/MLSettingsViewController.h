//
//  MLSettingsViewController.h
//  Shalby
//
//  Created by Mashhood Rastgar on 8/10/13.
//  Copyright (c) 2013 Mashhood Rastgar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MLSettingsViewController : NSViewController <NSTextFieldDelegate>

enum FieldTag {
    FieldTagInterval,
    FieldTagUpperLevel,
    FieldTagLowerLevel
};


@property (weak) IBOutlet NSTextField *interval;
@property (weak) IBOutlet NSTextField *upperLevel;
@property (weak) IBOutlet NSTextField *lowerLevel;


-(IBAction)exit:(NSButton *)sender;
-(IBAction)closeSettings:(NSButton *)sender;

@end
