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
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *outputDirectory = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    
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


@end
