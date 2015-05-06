#import "X_TableView.h"

@implementation X_TableViewCell


-(void)initialize{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)update{
    
}

-(void)didSelect{
    [self dispatchCellEventWithName:self.cellData[kCellDidSelect]];
}

-(CGFloat)getCellHeight{
    return self.frame.size.height;
}

-(void)dispatchCellEventWithName:(NSString *)name{
    [self.xTableView dispatchCellEventWithName:name data:self.cellData];
}

@end
