
#import "X_TableView.h"

@interface BasicCell : X_TableViewCell
@end

@implementation BasicCell

- (void)update{
    self.textLabel.text = self.cellData[@"text"];
}

-(void)didSelect{
    [super callEvent:self.cellData[@"onClick"]];
}

@end
