//
//  ViewController.m
//  NVRadioData
//
//  Created by mac-228 on 28.08.17.
//  Copyright © 2017 mac-228. All rights reserved.
//

#import "LoginViewController.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
  
}

-(void)viewWillAppear{
      NSLog(@"viewWillAppear");
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self
                                                       andSelector:@selector(handleAppleEvent:withReplyEvent:)
                                                     forEventClass:kInternetEventClass
                                                        andEventID:kAEGetURL];
}


- (void)handleAppleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
    NSURL *url = [NSURL URLWithString:[[event paramDescriptorForKeyword:keyDirectObject] stringValue]];
    DBOAuthResult *authResult = [DBClientsManager handleRedirectURL:url];
    if (authResult != nil) {
        if ([authResult isSuccess]) {
            NSLog(@"Success! User is logged into Dropbox.");
        } else if ([authResult isCancel]) {
            NSLog(@"Authorization flow was manually canceled by user!");
        } else if ([authResult isError]) {
            NSLog(@"Error: %@", authResult);
        }
        // this forces your app to the foreground, after it has handled the browser redirect
        [[NSRunningApplication currentApplication]
         activateWithOptions:(NSApplicationActivateAllWindows | NSApplicationActivateIgnoringOtherApps)];
    }
}


- (IBAction)buttonAction:(NSButton *)sender {
    [DBClientsManager authorizeFromControllerDesktop:[NSWorkspace sharedWorkspace]
                                          controller:self
                                             openURL:^(NSURL *url){ [[NSWorkspace sharedWorkspace] openURL:url]; }];
}


@end
