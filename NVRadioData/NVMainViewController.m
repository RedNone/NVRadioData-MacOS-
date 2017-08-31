
#import "NVMainViewController.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>
#import "NVDropBoxManager.h"
#import "NVMainViewController.h"
#import "NVRadioDataModel.h"
#import <Foundation/Foundation.h>
#import "AVFoundation/AVFoundation.h"

@interface NVMainViewController ()
@property(nonatomic,strong) DBUserClient *dbUser;
@property(nonatomic,strong) NVDropBoxManager *dropBoxManager;
@property(nonatomic,strong) AVPlayer *player;
@property(nonatomic,assign) NSInteger currentRadioCheck;
@property(nonatomic,assign) bool isCheckForSingleModel;
@end

@implementation NVMainViewController

-(void)dealloc{
    [self.player removeObserver:self forKeyPath:@"status"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)viewWillAppear{
    
    self.dropBoxManager = [NVDropBoxManager sharedManager];
    
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self
                                                       andSelector:@selector(handleAppleEvent:withReplyEvent:)
                                                     forEventClass:kInternetEventClass
                                                        andEventID:kAEGetURL];
    self.dbUser = [DBClientsManager authorizedClient];
    if([self.dbUser isAuthorized]){
        [self prepareViews];
    }
}

- (void)handleAppleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
    NSURL *url = [NSURL URLWithString:[[event paramDescriptorForKeyword:keyDirectObject] stringValue]];
    DBOAuthResult *authResult = [DBClientsManager handleRedirectURL:url];
    if (authResult != nil) {
        if ([authResult isSuccess]) {
            NSLog(@"Success! User is logged into Dropbox.");
            self.logInButton.hidden = YES;
            self.progressIndicator.hidden = NO;
            
            self.dbUser = [DBClientsManager authorizedClient];
            [self.dropBoxManager downLoadDataWithCompletionBlock:^{
                if(self.dropBoxManager.radioData){
                    self.currentRadioCheck = 0;
                    self.isCheckForSingleModel = NO;
                    NVRadioDataModel *model = [self.dropBoxManager.radioData objectAtIndex:self.currentRadioCheck];
                    [self playWithUrlString:model.radioUrl];
                }
                
            }];
        } else if ([authResult isCancel]) {
            NSLog(@"Authorization flow was manually canceled by user!");
            self.messageLabel.hidden = NO;
            self.messageLabel.stringValue = @"Authorization flow was manually canceled by user!";
        } else if ([authResult isError]) {
            NSLog(@"Error: %@", authResult);
            self.messageLabel.hidden = NO;
            self.messageLabel.stringValue = @"Authorization Error";
        }
         [[NSRunningApplication currentApplication]
         activateWithOptions:(NSApplicationActivateAllWindows | NSApplicationActivateIgnoringOtherApps)];
    }
}



- (void)prepareViews{
    self.messageLabel.hidden = YES;
    self.logInButton.hidden = YES;
    self.scrollViewWithTable.hidden = NO;
    self.headerView.hidden = NO;
    self.progressIndicator.hidden = YES;
}

- (void)convertRadioDataID{
    for(int i = 0; i < [self.dropBoxManager.radioData count]; i++){
        NVRadioDataModel *model = [self.dropBoxManager.radioData objectAtIndex:i];
        model.radioId = i;
    }
}

#pragma mark - Actions

- (IBAction)saveButtonAction:(NSButton *)sender {
    
    [self.dropBoxManager uploadDataToDropBox];
}

- (IBAction)deleteRowButtonAction:(NSButton *)sender {
    NSInteger currentRow = self.tableView.selectedRow;
    if(currentRow != -1){
        [self.dropBoxManager.radioData removeObjectAtIndex:currentRow];
        [self convertRadioDataID];
        
        [self.tableView beginUpdates];
        [self.tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:currentRow] withAnimation:NSTableViewAnimationSlideRight];
        [self.tableView endUpdates];
    }
}

- (IBAction)addNewRowButtonAction:(id)sender {
    NSInteger currentRow = self.tableView.selectedRow == -1 ? [self.dropBoxManager.radioData count] -1 : self.tableView.selectedRow;
    
    NVRadioDataModel *newModel = [NVRadioDataModel new];
    newModel.radioUrl = @"";
    newModel.radioName = @"";
    newModel.radioUrlStatus = @"";
    
    [self.dropBoxManager.radioData insertObject:newModel atIndex:currentRow+1];
    [self convertRadioDataID];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:currentRow+1] withAnimation: NSTableViewAnimationSlideLeft];
    [self.tableView endUpdates];
    
}

- (IBAction)logInButtonAction:(NSButton *)sender {
    [DBClientsManager authorizeFromControllerDesktop:[NSWorkspace sharedWorkspace]
                                          controller:self
                                             openURL:^(NSURL *url){ [[NSWorkspace sharedWorkspace] openURL:url]; }];
}

- (IBAction)radioNameTextFieldAction:(NSTextField *)sender {
    NSInteger currentRow = self.tableView.selectedRow;
    if(currentRow != -1){
        NVRadioDataModel *model = [self.dropBoxManager.radioData objectAtIndex:currentRow];
        model.radioName = sender.stringValue;
    }
}
- (IBAction)radioUrlTextFieldAction:(NSTextField *)sender {
    NSInteger currentRow = self.tableView.selectedRow;
    if(currentRow != -1){
        NVRadioDataModel *model = [self.dropBoxManager.radioData objectAtIndex:currentRow];
        model.radioUrl = sender.stringValue;
        
        self.currentRadioCheck = currentRow;
        self.isCheckForSingleModel = YES;
        [self playWithUrlString:model.radioUrl];
    }
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [self.dropBoxManager.radioData count];
}

#pragma mark - TableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
   
    NVRadioDataModel *model = [self.dropBoxManager.radioData objectAtIndex:row];
  
    NSString *text;
    NSString *identifire;    
   
    if(tableColumn == [[tableView tableColumns] objectAtIndex:0]){
        text = model.radioName;
        identifire = @"nameCellID";
    }
    if(tableColumn == [[tableView tableColumns] objectAtIndex:1]){
        text = model.radioUrl;
        identifire = @"urlCellID";
    }
    if(tableColumn == [[tableView tableColumns] objectAtIndex:2]){
        text = model.radioUrlStatus;
        identifire = @"statusCellID";
    }
    NSTableCellView *cell = [tableView makeViewWithIdentifier:identifire owner:nil];
    cell.textField.stringValue = text;
   
    return cell;
}

#pragma mark - Check Radio Status

-(void)playWithUrlString:(NSString *)urlString{
    
    if(![self validateUrl:urlString]){
        [self validateResultWithStatus:@"Unavailable"];
        return;
    }
    
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:urlString]];
    self.playerView.player = player;
    self.player = player;
    player.volume = 0.f;
    [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
    
}

- (BOOL)validateUrl:(NSString *)candidate {
    NSString *urlRegEx =
    @"^(?i)(?:(?:https?|ftp):\\/\\/)?(?:\\S+(?::\\S*)?@)?(?:(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[1-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,})))(?::\\d{2,5})?(?:\\/[^\\s]*)?$";
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.player && [keyPath isEqualToString:@"status"]) {
        if (self.player.status == AVPlayerStatusFailed) {
            [self validateResultWithStatus:@"Unavailable"];
        } else if (self.player.status == AVPlayerStatusReadyToPlay) {
            [self.playerView.player play];
            
            if ((self.playerView.player.rate != 0) && (self.playerView.player.error == nil)) {
                 [self validateResultWithStatus:@"Available"];
                 [self.playerView.player pause];
            }
            
        } else if (self.player.status == AVPlayerItemStatusUnknown) {
            [self validateResultWithStatus:@"Unavailable"];
        }
    }
}

- (void)validateResultWithStatus:(NSString *)status {
    
    NVRadioDataModel *model = [self.dropBoxManager.radioData objectAtIndex:self.currentRadioCheck];
    model.radioUrlStatus = status;
    
    if(self.isCheckForSingleModel){
        [self.tableView reloadDataForRowIndexes:[NSIndexSet indexSetWithIndex:self.currentRadioCheck]
                                   columnIndexes:[NSIndexSet indexSetWithIndex:2]];
        return;
    }
    ++self.currentRadioCheck;
    
    if(self.currentRadioCheck == [self.dropBoxManager.radioData count]){
        [self.tableView reloadData];
        [self prepareViews];
        return;
    } else {
        model = [self.dropBoxManager.radioData objectAtIndex:self.currentRadioCheck];
        [self playWithUrlString: model.radioUrl];
    }
}

@end
