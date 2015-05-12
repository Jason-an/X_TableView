#import "F1__ViewController.h"
#import "X_TableView.h"
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
    
    X_TableView *tbv = [X_TableView new];
    tbv.xDataSource = arr;

    [tbv addCellEventListenerWithName:@"liyingying" block:^(X_TableViewCell *cell) {
        NSLog(@"123123123");
       // [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [tbv addCellEventListenerWithName:@"f1" block:^(X_TableViewCell *cell) {
        NSLog(@"cellData=%@",cell.cellData);
    }];
    
    self.view = tbv;
}


@end
