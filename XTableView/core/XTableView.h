#import <UIKit/UIKit.h>
#import "XTableViewDataSource.h"

@interface XTableView : UITableView

//dataSource and delegateare has been removed
@property(nonatomic,weak)id<XTableViewDataSource> xDataSource;


@end