#import "KeybordTestViewController.h"
#import "X_TableView.h"
#import "X_KeybordEffect.h"

@interface KeybordTestViewController ()

@end

@implementation KeybordTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    X_TableView *tbv = [X_TableView new];
    tbv.xDataSource = [NSMutableArray new];
    for (int i=0; i<20; i++) {
        [tbv.xDataSource addObject:
            [@{kCellTag:@"TextfiledCell",kCellPlaceholder:@"___"} mutableCopy]
         ];
    }
    [tbv addEffect:[X_KeybordEffect new]];

    self.view = tbv;
}
@end
