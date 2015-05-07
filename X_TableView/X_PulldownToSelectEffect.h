#import "X_TableView.h"

@interface X_PulldownToSelectEffect : NSObject<X_TableViewEffect>
-(id)initWithItems:(NSArray*)items;
@property(nonatomic,copy)void(^didSelect)(int idx);
@end