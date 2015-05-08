#import "EditViewController.h"
#import "X_TableView.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *arr=[@[
                           [@{kCellTag:@"basic",kCellText:@"可删除",kCellCanEdit:@"yes"} mutableCopy],
                           [@{kCellTag:@"basic",kCellText:@"可删除",kCellCanEdit:@"yes"} mutableCopy],
                           [@{kCellTag:@"basic",kCellText:@"不可删除"} mutableCopy],
                           ]mutableCopy];
    
    
    X_TableView *tbv = [X_TableView new];
    tbv.xDataSource = arr;
    
    __weak X_TableView* weakTb = tbv;
    
    [tbv addCommitEditingEventWithBlock:^(UITableViewCellEditingStyle style, NSInteger index) {
        [weakTb.xDataSource removeObjectAtIndex:index];
        
        
        //temp
        [weakTb deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];

    }];
    
    
    self.view = tbv;
}


@end
