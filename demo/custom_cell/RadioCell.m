#import "X_TableView.h"

@interface RadioCell : X_TableViewCell
@end

@implementation RadioCell

- (void)update{
    self.textLabel.text = self.cellData[kCellText];
    
    if ([self.cellData[@"select"] boolValue]) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
        self.textLabel.textColor = [UIColor redColor];
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
        self.textLabel.textColor = [UIColor blackColor];
    }
  
}

-(void)didSelect{
    
    [self.xTableView.xDataSource
        x_update:@{kCellTag:@"radio",@"groupid":self.cellData[@"groupid"]}
        set:@{@"select":@"false"}
    ];
    
    self.cellData[@"select"] = @"true";
    
    [self.xTableView reloadData];
}

@end