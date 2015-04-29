# X_TableView

```objective-c
-(void)viewDidLoad{
    [super viewDidLoad];
    
    X_TableView *tbv = [[X_TableView alloc]init];
    tbv.xDataSource = [X_XMLDataSource xmlDataSourceWithFileName:_filename];
    
    self.view = tbv;
}
```
