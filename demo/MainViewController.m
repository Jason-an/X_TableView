#import "MainViewController.h"
#import "X_TableView.h"
#import "X_XMLDataSource.h"


#import "PulldownZoomViewController.h"



void showAlter(NSString *title)
{
    UIAlertView *baseAlert = [[UIAlertView alloc]
                              initWithTitle:title
                              message:@"" delegate:nil
                              cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [baseAlert show];
    
}


@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"demo";

    X_TableView *tbv = [[X_TableView alloc]init];
    tbv.xDataSource = [X_XMLDataSource xmlDataSourceWithFileName:@"test.xml"];
    
    __weak MainViewController *weakSelf = self;
    [tbv addCellEventListenerWithName:@"f1" block:^(NSMutableDictionary *cellData) {
        [weakSelf.navigationController pushViewController:[[PulldownZoomViewController alloc]init] animated:YES];
    }];
    
    [tbv addCellEventListenerWithName:@"f2" block:^(NSMutableDictionary *cellData) {
        showAlter(@"test");
    }];
    
    
    self.view = tbv;
}

@end
