#import "F1__ViewController.h"


@implementation F1__ViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    NSMutableArray *arr=[NSMutableArray new];
    
    for (int i=0; i<30; i++) {
        [arr addObject:[@{
                         kCellTag:@"basic",
                         kCellText:[NSString stringWithFormat:@"%d",i+1],
                         kCellDidSelect:@"f1"
                         } mutableCopy]];
        if (i==5) {
            [arr addObject:[@{
                              kCellTag:@"image",
                              kCellText:[NSString stringWithFormat:@"%d",i+1],
                              kCellDidSelect:@"liyingying"
                              } mutableCopy]];
        }
    }
    
    
    self.xTableView.xDataSource = arr;

    [self.xTableView addCellEventListenerWithName:@"liyingying" block:^(X_TableViewCell *cell) {
        NSLog(@"123123123");
       // [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.xTableView addCellEventListenerWithName:@"f1" block:^(X_TableViewCell *cell) {
        NSLog(@"cellData=%@",cell.cellData);
    }];
    
}


@end
