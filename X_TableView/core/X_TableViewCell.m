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

-(void)callEvent:(NSString *)key{
    [self.xTableView callEvent:key data:self.cellData];
}

@end
