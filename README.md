# X_TableView

```objective-c
X_TableView *tbv = [[X_TableView alloc]init];
    tbv.xDataSource = [X_XMLDataSource xmlDataSourceWithFileName:@"test.xml"];
    
    __weak MainViewController *weakSelf = self;
    [tbv addEventListener:@"f1" block:^(NSMutableDictionary *cellData) {
        [weakSelf.navigationController pushViewController:[[PulldownZoomViewController alloc]init] animated:YES];
    }];
    
    [tbv addEventListener:@"f2" block:^(NSMutableDictionary *cellData) {
        NSLog(@"test");
    }];
```
