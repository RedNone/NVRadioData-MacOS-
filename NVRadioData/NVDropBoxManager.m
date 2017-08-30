#import "NVDropBoxManager.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>
#import "NVRadioDataModel.h"

@interface NVDropBoxManager ()

@property(nonatomic,strong) DBUserClient *dbUser;

@end

@implementation NVDropBoxManager

+ (NVDropBoxManager*)sharedManager {
    static NVDropBoxManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - DropBox data

- (void)downLoadDataWithCompletionBlock:(void(^)(void))completionBlock{
    
    self.dbUser = [DBClientsManager authorizedClient];
       
    [[self.dbUser.filesRoutes downloadData:@"/FMJson.json"]
     setResponseBlock:^(DBFILESFileMetadata *result, DBFILESDownloadError *routeError, DBRequestError *error,
                        NSData *fileContents) {
         if (result) {            
             
             NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:fileContents options: 0 error:nil];
             
             self.radioData = [[NSMutableArray alloc] initWithCapacity:[array count]];
             
             for (int i = 0; i < [array count]; i++) {
                 NSDictionary *dict = [array objectAtIndex:i];
                 NVRadioDataModel *model = [NVRadioDataModel new];
                 model.radioId = [[dict valueForKey:@"id"] intValue];
                 model.radioName = [dict valueForKey:@"name"];
                 model.radioUrl = [dict valueForKey:@"url"];
                 [self.radioData addObject:model];
             }
         } else {
             NSLog(@"%@\n%@\n", routeError, error);
         }
         completionBlock();
     }];
}

- (void)uploadDataToDropBox{
    NSData *jsonData = [self createJsonFromArray:self.radioData];
    
    NSString *somestring = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",somestring);
    
    DBFILESWriteMode *mode = [[DBFILESWriteMode alloc] initWithOverwrite];
    
    [[[self.dbUser.filesRoutes uploadData:@"/FMJson.json"
                                mode:mode
                          autorename:@(YES)
                      clientModified:nil
                                mute:@(NO)
                           inputData:jsonData]
      setResponseBlock:^(DBFILESFileMetadata *result, DBFILESUploadError *routeError, DBRequestError *networkError) {
          if (result) {
              NSLog(@"%@\n", result);
          } else {
              NSLog(@"%@\n%@\n", routeError, networkError);
          }
      }] setProgressBlock:^(int64_t bytesUploaded, int64_t totalBytesUploaded, int64_t totalBytesExpectedToUploaded) {
          NSLog(@"\n%lld\n%lld\n%lld\n", bytesUploaded, totalBytesUploaded, totalBytesExpectedToUploaded);
      }];
}

- (NSData *)createJsonFromArray:(NSArray *)array{
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for(NVRadioDataModel *model in array){
        NSDictionary *dict = @{@"id" : [NSString stringWithFormat:@"%ld",(long)model.radioId], @"name" : model.radioName, @"url" : model.radioUrl};
        [newArray addObject:dict];
    }
  
    return [NSJSONSerialization dataWithJSONObject:newArray
                                           options:kNilOptions
                                             error:nil];
}

@end
