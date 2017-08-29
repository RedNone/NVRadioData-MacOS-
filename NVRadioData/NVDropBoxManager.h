//
//  NVDropBoxManager.h
//  NVRadioData
//
//  Created by mac-228 on 29.08.17.
//  Copyright © 2017 mac-228. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NVDropBoxManager : NSObject

@property(nonatomic,strong) NSMutableArray *radioData;

+ (NVDropBoxManager*)sharedManager;
- (void)downLoadDataWithCompletionBlock:(void(^)(void))completionBlock;

@end
