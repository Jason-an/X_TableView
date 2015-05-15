#import "PulldownZoomTestViewController.h"
#import "X_PulldownZoomEffect.h"

@implementation PulldownZoomTestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"pulldown zoom";
    
    self.xTableView.xDataSource = [NSMutableArray x_ArrayWithXmlFile:@"PulldownZoomViewController.xml"];
    [self.xTableView addEffect:[X_PulldownZoomEffect new]];
    
}


@end
