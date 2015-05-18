#import "XMLTestViewController.h"

@implementation XMLTestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.xTableView.xDataSource = [NSMutableArray x_ArrayWithXmlFile:_filename];
}

@end
