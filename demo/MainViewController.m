#import "MainViewController.h"
#import "X_TableView.h"
#import "XMLTestViewController.h"


@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"demo";
    
    self.xTableView.xDataSource = [NSMutableArray x_ArrayWithXmlFile:@"MainViewController.xml"];
    
    __weak MainViewController *weakSelf = self;
    
    [self.xTableView addCellEventListenerWithName:@"push" block:^(X_TableViewCell *cell) {
        UIViewController *vc = [NSClassFromString(cell.cellData[@"viewController"]) new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
    [self.xTableView addCellEventListenerWithName:@"onPushTest" block:^(X_TableViewCell *cell) {
        XMLTestViewController *vc = [XMLTestViewController new];
        vc.title = cell.cellData[kCellText];
        vc.filename = cell.cellData[@"filename"];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
}

@end
