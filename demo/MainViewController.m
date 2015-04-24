#import "MainViewController.h"
#import "X_TableView.h"
#import "X_XMLDataSource.h"


#import "PulldownZoomViewController.h"

@end


@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"demo";

    X_TableView *tbv = [[X_TableView alloc]init];
    tbv.xDataSource = [X_XMLDataSource xmlDataSourceWithFileName:@"test.xml"];
    
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
