#import "XMLTestViewController.h"
#import "X_TableView.h"

@implementation XMLTestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    X_TableView *tbv = [X_TableView new];
    tbv.xDataSource = [NSMutableArray x_ArrayWithXmlFile:_filename];
    
    self.view = tbv;
}

@end
