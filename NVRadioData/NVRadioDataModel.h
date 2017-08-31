#import <Foundation/Foundation.h>

@interface NVRadioDataModel : NSObject

@property(nonatomic,assign) NSInteger radioId;
@property(nonatomic,strong) NSString *radioName;
@property(nonatomic,strong) NSString *radioUrl;
@property(nonatomic,strong) NSString *radioUrlStatus;
@end
