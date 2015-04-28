#import "XMLTestViewController.h"
#import "X_TableView.h"
#import "X_XMLDataSource.h"

@implementation XMLTestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    X_TableView *tbv = [[X_TableView alloc]init];
    tbv.xDataSource = [X_XMLDataSource xmlDataSourceWithFileName:_filename];
    
    self.view = tbv;
}

@end
