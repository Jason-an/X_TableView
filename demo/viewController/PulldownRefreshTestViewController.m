#import "PulldownRefreshTestViewController.h"
#import "X_TableView.h"
#import "X_PulldownRefreshEffect.h"

@interface PulldownRefreshTestViewController ()
@property(nonatomic)X_TableView *tbv;
@property(nonatomic)X_PulldownRefreshEffect *effect;
@end

@implementation PulldownRefreshTestViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"下拉刷新测试";
    
    _tbv = [X_TableView new];
    _tbv.xDataSource = [@[
                         [@{kCellTag:@"basic",kCellText:@"数据1111"}mutableCopy],
                         [@{kCellTag:@"basic",kCellText:@"数据1111"}mutableCopy],
                         [@{kCellTag:@"basic",kCellText:@"数据1111"}mutableCopy],
                       ] mutableCopy];
    
    _effect = [X_PulldownRefreshEffect new];
    
    
    __weak PulldownRefreshTestViewController *weakSelf = self;
    _effect.onRefreshBlock=^{
        //加载数据....
        [weakSelf.tbv.xDataSource addObjectsFromArray:
         @[
           [@{kCellTag:@"basic",kCellText:@"数据222"}mutableCopy],
           [@{kCellTag:@"basic",kCellText:@"数据222"}mutableCopy],
           [@{kCellTag:@"basic",kCellText:@"数据222"}mutableCopy],
           ]
         ];
        [weakSelf.tbv reloadData];
        [weakSelf.effect endRefreshing];
    };
    
    [_tbv addEffect:_effect];
    
    self.view = _tbv;
}


@end
