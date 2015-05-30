#import "XMLTestViewController.h"
#import "X_PulldownZoomEffect.h"

@implementation XMLTestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //设置数据源
    self.xTableView.xDataSource = [NSMutableArray x_ArrayWithXmlFile:@"test_data.xml"];
    
    //添加特效
    [self.xTableView addEffect:[X_PulldownZoomEffect new]];
}

@end
