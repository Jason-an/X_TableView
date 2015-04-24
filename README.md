# X_TableView

```objective-c
X_TableView *tbv = [[X_TableView alloc]init];
tbv.xDataSource = [X_XMLDataSource xmlDataSourceWithFileName:@"test.xml"];

[tbv addEventListener:@"test" block:^(NSMutableDictionary *cellData) {
    NSLog(@"test");
}];
```
