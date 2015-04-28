#import "X_TableView.h"

@interface NoneCell : X_TableViewCell
@end

@implementation NoneCell
-(CGFloat)getCellHeight{
    return [self.cellData[@"height"] floatValue];
}
@end
