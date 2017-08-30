//
//  NVRadioStatus.h
//  NVRadioData
//
//  Created by mac-228 on 29.08.17.
//  Copyright © 2017 mac-228. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVRadioStatus : NSObject

- (void)initUrlCheckWithCompletionBlock:(void(^)(void))completionBlock;

@end
