#import "X_TableView.h"

@interface X_PulldownRefreshEffect : NSObject<X_TableViewEffect>
-(void)endRefreshing;
@property(nonatomic,copy)void(^onRefreshBlock)();
@end
