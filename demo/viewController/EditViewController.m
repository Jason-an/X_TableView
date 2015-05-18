#import "EditViewController.h"

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
    
    
    self.xTableView.xDataSource = arr;
    
    __weak X_TableView* weakTb = self.xTableView;
    
    [self.xTableView addCommitEditingEventWithBlock:^(UITableViewCellEditingStyle style, NSInteger index) {
        [weakTb.xDataSource removeObjectAtIndex:index];
        
        
        //temp
        [weakTb deleteRowsAtIndexPaths:[NSArray arrayWithObject:[weakTb indexToIndexPath:index]] withRowAnimation:UITableViewRowAnimationAutomatic];

    }];
    
}


@end
