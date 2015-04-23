
#import "XTableView.h"

@interface BasicCell : XTableViewCell
@end

@implementation BasicCell

- (void)update{
    self.textLabel.text = self.cellData[@"text"];
}

-(void)didSelect{
    [super callEvent:self.cellData[@"onClick"]];
}

@end
