#import "PulldownZoomTestViewController.h"
#import "X_TableView.h"
#import "X_XMLDataSource.h"
#import "X_PulldownZoomEffect.h"

@implementation PulldownZoomTestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"pulldown zoom";
    
    X_TableView *tbv = [[X_TableView alloc]init];
    tbv.xDataSource = [X_XMLDataSource xmlDataSourceWithFileName:@"PulldownZoomViewController.xml"];
    [tbv addEffect:[[X_PulldownZoomEffect alloc]init]];
    
    self.view = tbv;
}


@end
