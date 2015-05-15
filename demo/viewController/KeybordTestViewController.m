#import "KeybordTestViewController.h"
#import "X_KeybordEffect.h"

@interface KeybordTestViewController ()

@end

@implementation KeybordTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.xTableView.xDataSource = [NSMutableArray new];
    for (int i=0; i<20; i++) {
        [self.xTableView.xDataSource addObject:
            [@{kCellTag:@"TextfiledCell",kCellPlaceholder:@"___"} mutableCopy]
         ];
    }
    [self.xTableView addEffect:[X_KeybordEffect new]];

}
@end
