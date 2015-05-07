#import "PulldownToSelectTestViewController.h"
#import "X_TableView.h"
#import "X_PulldownToSelectEffect.h"

@interface PulldownToSelectTestViewController ()

@end

@implementation PulldownToSelectTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *arr=[@[
                           [@{kCellTag:@"basic",kCellText:@"hello"} mutableCopy],
                           [@{kCellTag:@"basic",kCellText:@"hello"} mutableCopy],
                           [@{kCellTag:@"basic",kCellText:@"hello"} mutableCopy],
                           ]mutableCopy];

    
    X_TableView *tbv = [X_TableView new];
    tbv.xDataSource = arr;
    
    X_PulldownToSelectEffect *effect = [[X_PulldownToSelectEffect alloc]initWithItems:@[@"a",@"b",@"c"]];
    [tbv addEffect:effect];
    
    
    self.view = tbv;
}


@end
