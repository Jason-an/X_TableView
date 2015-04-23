#import <UIKit/UIKit.h>
#import "XTableViewDataSource.h"

@interface XTableView : UITableView

//dataSource and delegate are disabled
@property(nonatomic,weak)id<XTableViewDataSource> xDataSource;


@end