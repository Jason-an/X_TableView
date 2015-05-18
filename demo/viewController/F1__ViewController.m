#import "F1__ViewController.h"
#import "X_TableView.h"
@implementation F1__ViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    X_TableView *tbv = [X_TableView new];
    
    NSMutableArray *arr=[NSMutableArray new];
    
    
    [arr addObject:[@{
                      kCellTag:@"TestCell",
                      @"test":@"hasdihfiuahsdfiuh",
                      kCellDidSelect:@"123",
                      } mutableCopy]];
    [tbv addCellEventListenerWithName:@"test2" block:^(X_TableViewCell *cell) {
        
    }];
    [tbv addCellEventListenerWithName:@"testTouch" block:^(X_TableViewCell *cell) {
        NSLog(@"%@",cell.cellData);
    }];
    
    [tbv addCellEventListenerWithName:@"123" block:^(X_TableViewCell *cell) {
        NSLog(@"%@",cell.cellData);
    }];
    
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
