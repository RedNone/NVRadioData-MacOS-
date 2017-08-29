//
//  AppDelegate.m
//  NVRadioData
//
//  Created by mac-228 on 28.08.17.
//  Copyright © 2017 mac-228. All rights reserved.
//

#import "AppDelegate.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [DBClientsManager setupWithAppKeyDesktop:@"6vmv9du4wozfqwt"];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
