#import <UIKit/UIKit.h>

@interface XTableViewCell : UITableViewCell

//@property(nonatomic,weak) XTableView* xTableView;
@property(nonatomic) NSMutableDictionary* cellData;

-(void)initialize;
-(void)update;
-(void)didSelect;
-(CGFloat)getCellHeight;

//?
-(void)callEvent:(NSString *)key;

@end
