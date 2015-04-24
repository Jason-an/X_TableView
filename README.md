# XTableView

```objective-c
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
```
