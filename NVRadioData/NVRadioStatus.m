#import "NVRadioStatus.h"
#import "NVRadioDataModel.h"
#import "NVDropBoxManager.h"
#import <Foundation/Foundation.h>
#import "AVFoundation/AVFoundation.h"

@interface NVRadioStatus ()
@property(nonatomic,strong) AVPlayer *songPlayer;
@property(nonatomic,copy) void (^completionBlock)(void);
@property(nonatomic,assign) NSInteger currentRadio;
@property(nonatomic,strong) NSArray *radioData;
@property(nonatomic,strong) NVRadioDataModel *currentModel;

@end

@implementation NVRadioStatus

-(void)dealloc{
    [self.songPlayer removeObserver:self forKeyPath:@"status"];
}

- (void)initUrlCheckWithCompletionBlock:(void(^)(void))completionBlock{
    self.completionBlock = completionBlock;
    self.radioData = [[NVDropBoxManager sharedManager] radioData];
    
    self.currentModel = [self.radioData objectAtIndex:0];
    self.currentRadio = 0;
    
    //[self testLoadWithStrig:self.currentModel.radioUrl];
    [self playWithUrlString: self.currentModel.radioUrl];
}

-(void)playWithUrlString:(NSString *)urlString{
    NSString *radioURL = urlString;
    AVPlayer *player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:radioURL]];
    self.songPlayer = player;
   
    [self.songPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
}


/*- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.songPlayer && [keyPath isEqualToString:@"status"]) {
        if (self.songPlayer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            self.currentModel.radioUrlStatus = @"Unavailable";
        } else if (self.songPlayer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            self.currentModel.radioUrlStatus = @"Available";
        } else if (self.songPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            self.currentModel.radioUrlStatus = @"Unavailable";
        }
        ++self.currentRadio;
        if(self.currentRadio == [self.radioData count]){
            self.completionBlock();
            return;
        } else {
            self.currentModel = [self.radioData objectAtIndex:self.currentRadio];
            [self playWithUrlString: self.currentModel.radioUrl];
        }
        
    }
}*/


/*- (void)testLoadWithStrig:(NSString *)someString{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    AFHTTPResponseSerializer *responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"audio/x-mpegurl", @"text/javascript", @"text/html",@"text/plain", nil];
    manager.responseSerializer = responseSerializer;
    
    NSURL *URL = [NSURL URLWithString:@"http://lider-fm.by:8000/radio"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
             self.currentModel.radioUrlStatus = @"Available";
        } else {
             self.currentModel.radioUrlStatus = @"Unavailable";
        }
        
       /* ++self.currentRadio;
        if(self.currentRadio == [self.radioData count]){
            self.completionBlock();
            return;
        } else {
            self.currentModel = [self.radioData objectAtIndex:self.currentRadio];
            [self testLoadWithStrig:self.currentModel.radioUrl];
        }*/

   /* }];
    [dataTask resume];
}*/

@end
