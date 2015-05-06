#import "X_PulldownRefreshEffect.h"
#import "X_TableView.h"

@interface X_PulldownRefreshEffect()
@property(nonatomic)UIRefreshControl* refreshControl;
@end

@implementation X_PulldownRefreshEffect


-(void)endRefreshing{
    [self.refreshControl endRefreshing];
}


-(void)onRefresh{
    if (self.onRefreshBlock) {
        self.onRefreshBlock();
    }
}

-(void)onEffectAdd:(X_TableView *)xTableView{
    _refreshControl = [UIRefreshControl new];
    [_refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [xTableView insertSubview:_refreshControl atIndex:0];
}

-(void)onEffectRemove:(X_TableView *)xTableView{
    [_refreshControl removeFromSuperview];
}


@end
