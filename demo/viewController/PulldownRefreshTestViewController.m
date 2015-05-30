#import "PulldownRefreshTestViewController.h"
#import "X_PulldownRefreshEffect.h"

@interface PulldownRefreshTestViewController ()
@property(nonatomic)X_PulldownRefreshEffect *effect;
@end

@implementation PulldownRefreshTestViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"下拉刷新测试";
    
    __weak PulldownRefreshTestViewController *weakSelf = self;
    
    
    self.xTableView.xDataSource = [@[
                         [@{kCellTag:@"basic",kCellText:@"数据1111"}mutableCopy],
                         [@{kCellTag:@"basic",kCellText:@"数据1111"}mutableCopy],
                         [@{kCellTag:@"basic",kCellText:@"数据1111"}mutableCopy],
                       ] mutableCopy];
    
    
    _effect = [X_PulldownRefreshEffect new];
    
    _effect.onRefreshBlock=^{
        //加载数据....
        [weakSelf.xTableView.xDataSource addObjectsFromArray:
         @[
           [@{kCellTag:@"basic",kCellText:@"数据222"}mutableCopy],
           [@{kCellTag:@"basic",kCellText:@"数据222"}mutableCopy],
           [@{kCellTag:@"basic",kCellText:@"数据222"}mutableCopy],
           ]
         ];
        [weakSelf.xTableView reloadData];
        [weakSelf.effect endRefreshing];
    };
    
    [self.xTableView addEffect:_effect];
    
}


@end
