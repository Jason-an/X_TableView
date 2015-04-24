#import "PulldownZoomViewController.h"
#import "XTableView.h"
#import "XMLDataSource.h"
#import "PulldownZoomEffect.h"

@implementation PulldownZoomViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"pulldown zoom";
    
    XTableView *tbv = [[XTableView alloc]init];
    tbv.xDataSource = [XMLDataSource xmlDataSourceWithFileName:@"PulldownZoomViewController.xml"];
    [tbv addEffect:[[PulldownZoomEffect alloc]init]];
    
    self.view = tbv;
}


@end
