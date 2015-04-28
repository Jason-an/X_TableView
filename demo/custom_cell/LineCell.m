#import "X_TableView.h"

@interface LineCell : X_TableViewCell
@end

@implementation LineCell
-(void)update{
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
}
@end
