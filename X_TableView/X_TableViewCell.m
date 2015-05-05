#import "X_TableView.h"

@implementation X_TableViewCell


-(void)initialize{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)update{
    
}

-(void)didSelect{
    
}

-(CGFloat)getCellHeight{
    return self.frame.size.height;
}

-(void)dispatchCellEventWithName:(NSString *)name{
    [self.xTableView dispatchCellEventWithName:name data:self.cellData];
}

@end
