#import "X_TableView.h"


@implementation X_TableViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    _xTableView = [X_TableView new];
    self.view = _xTableView;
}

@end
