#import "MainViewController.h"
#import "X_TableView.h"
#import "XMLTestViewController.h"


@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"demo";
    

    X_TableView *tbv = [X_TableView new];
    tbv.xDataSource = [NSMutableArray x_ArrayWithXmlFile:@"MainViewController.xml"];
    
    __weak MainViewController *weakSelf = self;
    
    [tbv addCellEventListenerWithName:@"push" block:^(NSMutableDictionary *cellData) {
        UIViewController *vc = [[NSClassFromString(cellData[@"viewController"]) alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
    [tbv addCellEventListenerWithName:@"onPushTest" block:^(NSMutableDictionary *cellData) {
        XMLTestViewController *vc = [XMLTestViewController new];
        vc.title = cellData[kCellText];
        vc.filename = cellData[@"filename"];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
    self.view = tbv;
}

@end
