#import "X_TableView.h"

@interface ImageCell : X_TableViewCell
@end

@interface ImageCell()
@property(nonatomic)IBOutlet UIImageView* imgView;
@end

@implementation ImageCell

- (void)update{
    _imgView.image = [UIImage imageNamed:@"hello.jpg"];
}

//-(CGFloat)getCellHeight{
//    return 256;
//}
//-(void)didSelect
//{
//        [super dispatchCellEventWithName:self.cellData[@"onClick"]];
//}
@end
