
#import "NVMainViewController.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>
#import "NVDropBoxManager.h"
#import "NVMainViewController.h"
#import "NVRadioDataModel.h"
#import "NVRadioStatus.h"

@interface NVMainViewController ()
@property(nonatomic,strong) DBUserClient *dbUser;
@property(nonatomic,strong) NVDropBoxManager *dropBoxManager;
@end

@implementation NVMainViewController

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
            [self prepareViews];
            self.dbUser = [DBClientsManager authorizedClient];
            [self.dropBoxManager downLoadDataWithCompletionBlock:^{
                if(self.dropBoxManager.radioData){
                    [self prepareViews];
                    [self.tableView reloadData];
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
}

- (void)convertRadioDataID{
    for(int i = 0; i < [self.dropBoxManager.radioData count]; i++){
        NVRadioDataModel *model = [self.dropBoxManager.radioData objectAtIndex:i];
        model.radioId = i;
    }
}

#pragma mark - Actions

- (IBAction)saveButtonAction:(NSButton *)sender {
   /* for(int i = 0; i < [self.dropBoxManager.radioData count]; i++){
        NVRadioDataModel *model = [self.dropBoxManager.radioData objectAtIndex:i];
        NSLog(@"\nName: %@ \n URL: %@",model.radioName,model.radioUrl);
    }*/
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
        NSLog(@"%@",model.radioName);
    }
}
- (IBAction)radioUrlTextFieldAction:(NSTextField *)sender {
    NSInteger currentRow = self.tableView.selectedRow;
    if(currentRow != -1){
        NVRadioDataModel *model = [self.dropBoxManager.radioData objectAtIndex:currentRow];
        model.radioUrl = sender.stringValue;
        NSLog(@"%@",model.radioUrl);
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
    
    NSTableCellView *cell = [tableView makeViewWithIdentifier:identifire owner:nil];
    cell.textField.stringValue = text;
   
    return cell;
}



@end
