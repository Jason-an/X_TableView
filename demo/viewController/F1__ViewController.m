#import "F1__ViewController.h"
#import "X_TableView.h"
@implementation F1__ViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    for (int i=0; i<1000; i++) {
        [arr addObject:[@{
                         kCellTag:@"basic",
                         kCellText:[NSString stringWithFormat:@"%d",i+1],
                         kCellDidSelect:@"f1"
                         } mutableCopy]];
        if (i==29) {
            [arr addObject:[@{
                              kCellTag:@"image",
                              kCellText:[NSString stringWithFormat:@"%d",i+1],
                              kCellDidSelect:@"liyingying"
                              } mutableCopy]];
        }
    }
    
    X_TableView *tbv = [[X_TableView alloc]init];
    tbv.xDataSource = arr;

    [tbv addCellEventListenerWithName:@"liyingying" block:^(NSMutableDictionary *cellData) {
        NSLog(@"123123123");
       // [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [tbv addCellEventListenerWithName:@"f1" block:^(NSMutableDictionary *cellData) {
        NSLog(@"cellData=%@",cellData);
    }];
    
    self.view = tbv;
}


@end
