#import "F1__ViewController.h"
#import "X_TableView.h"
@implementation F1__ViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    for (int i=0; i<1000; i++) {
        [arr addObject:[@{
                         @"__tag__":@"basic",
                         @"text":[NSString stringWithFormat:@"%d",i+1],
                         @"onClick":@"f1"
                         } mutableCopy]];
        if (i==29) {
            [arr addObject:[@{
                              @"__tag__":@"image",
                              @"text":[NSString stringWithFormat:@"%d",i+1],
                              @"onClick":@"liyingying"
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
