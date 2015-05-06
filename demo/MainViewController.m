#import "MainViewController.h"
#import "X_TableView.h"
#import "PulldownZoomTestViewController.h"
#import "XMLTestViewController.h"
#import "F1__ViewController.h"
#import "PulldownRefreshTestViewController.h"


@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"demo";
    

    X_TableView *tbv = [X_TableView new];
    tbv.xDataSource = [NSMutableArray x_ArrayWithXmlFile:@"MainViewController.xml"];
    
    __weak MainViewController *weakSelf = self;
    
    [tbv addCellEventListenerWithName:@"onPullDownRefreshTest" block:^(NSMutableDictionary *cellData) {
        [weakSelf.navigationController pushViewController:[PulldownRefreshTestViewController new] animated:YES];
    }];
    
    [tbv addCellEventListenerWithName:@"onWebDataTest" block:^(NSMutableDictionary *cellData) {
        [weakSelf.navigationController pushViewController:[F1__ViewController new] animated:YES];
    }];
    
    [tbv addCellEventListenerWithName:@"onPulldownZoomTest" block:^(NSMutableDictionary *cellData) {
        [weakSelf.navigationController pushViewController:[PulldownZoomTestViewController new] animated:YES];
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
