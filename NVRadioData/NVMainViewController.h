//
//  NVLogInViewController.h
//  NVRadioData
//
//  Created by mac-228 on 28.08.17.
//  Copyright © 2017 mac-228. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NVMainViewController : NSViewController

@property (weak) IBOutlet NSScrollView *scrollViewWithTable;
@property (weak) IBOutlet NSTextField *messageLabel;
@property (weak) IBOutlet NSButton *logInButton;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSView *headerView;


- (IBAction)saveButtonAction:(NSButton *)sender;
- (IBAction)deleteRowButtonAction:(NSButton *)sender;
- (IBAction)addNewRowButtonAction:(id)sender;
- (IBAction)logInButtonAction:(NSButton *)sender;

@end
