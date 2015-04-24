#import "MainViewController.h"
#import "XTableView.h"
#import "XMLDataSource.h"

NSMutableDictionary* AA(NSDictionary *dic){
    return [[NSMutableDictionary alloc]initWithDictionary:dic];
}

@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"demo";
    
    XTableView *tbv = [[XTableView alloc]init];
    tbv.xDataSource = [XMLDataSource xmlDataSourceWithFileName:@"test.xml"];
    
    [tbv addEventListener:@"f1" block:^(NSMutableDictionary *cellData) {
        NSLog(@"f1");
    }];
    
    [tbv addEventListener:@"f2" block:^(NSMutableDictionary *cellData) {
        NSLog(@"f2");
    }];
    
    self.view = tbv;
}

@end
