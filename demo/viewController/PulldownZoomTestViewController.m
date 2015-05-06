#import "PulldownZoomTestViewController.h"
#import "X_TableView.h"
#import "X_PulldownZoomEffect.h"

@implementation PulldownZoomTestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"pulldown zoom";
    
    X_TableView *tbv = [X_TableView new];
    tbv.xDataSource = [NSMutableArray x_ArrayWithXmlFile:@"PulldownZoomViewController.xml"];
    [tbv addEffect:[X_PulldownZoomEffect new]];
    
    self.view = tbv;
}


@end
