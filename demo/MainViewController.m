#import "MainViewController.h"
#import "X_TableView.h"
#import "XMLTestViewController.h"


@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title=@"demo";
    
    __weak MainViewController *weakSelf = self;
    
    
    self.xTableView.xDataSource = [NSMutableArray x_ArrayWithXmlFile:@"data.xml"];
    
    [self.xTableView addCellEventListenerWithName:@"push" block:^(X_TableViewCell *cell) {
        NSString *className = cell.cellData[@"viewController"];
        UIViewController *vc = [NSClassFromString(className) new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
}

@end
