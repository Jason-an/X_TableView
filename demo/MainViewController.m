#import "MainViewController.h"
#import "XTableView.h"
#import "XMLDataSource.h"


#import "PulldownZoomViewController.h"

@end


@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"demo";

    XTableView *tbv = [[XTableView alloc]init];
    tbv.xDataSource = [XMLDataSource xmlDataSourceWithFileName:@"test.xml"];
    
    __weak MainViewController *weakSelf = self;
    [tbv addEventListener:@"f1" block:^(NSMutableDictionary *cellData) {
        [weakSelf.navigationController pushViewController:[[PulldownZoomViewController alloc]init] animated:YES];
    }];
    
    [tbv addEventListener:@"f2" block:^(NSMutableDictionary *cellData) {
        NSLog(@"test");
    }];
    
    
    self.view = tbv;
}

@end
