#import "MainViewController.h"
#import "X_TableView.h"
#import "PulldownZoomTestViewController.h"
#import "XMLTestViewController.h"
#import "F1__ViewController.h"

@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"demo";
    

    X_TableView *tbv = [[X_TableView alloc]init];
    tbv.xDataSource = [NSMutableArray x_ArrayWithXmlFile:@"MainViewController.xml"];
    
    __weak MainViewController *weakSelf = self;
    
    [tbv addCellEventListenerWithName:@"onWebDataTest" block:^(NSMutableDictionary *cellData) {
        [weakSelf.navigationController pushViewController:[[F1__ViewController alloc]init] animated:YES];
    }];
    
    [tbv addCellEventListenerWithName:@"onPulldownZoomTest" block:^(NSMutableDictionary *cellData) {
        [weakSelf.navigationController pushViewController:[[PulldownZoomTestViewController alloc]init] animated:YES];
    }];
    
    
    [tbv addCellEventListenerWithName:@"onPushTest" block:^(NSMutableDictionary *cellData) {
        XMLTestViewController *vc = [[XMLTestViewController alloc]init];
        vc.title = cellData[@"text"];
        vc.filename = cellData[@"filename"];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
    self.view = tbv;
}

@end
