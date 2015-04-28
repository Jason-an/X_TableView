#import "X_TableView.h"

@interface SwitchCell : X_TableViewCell
@end


@interface SwitchCell()

@property(nonatomic)IBOutlet UISwitch* sw;
@end

@implementation SwitchCell

- (void)update{
    self.textLabel.text = self.cellData[@"text"];
    self.textLabel.textColor=[UIColor whiteColor];
    self.textLabel.backgroundColor=[UIColor clearColor];
    bool b = [self.cellData[@"select"] boolValue] || [self.cellData[@"select"] boolValue] ;
    [self.sw setOn:b];
}

-(IBAction)swChange{
    self.cellData[@"select"] = self.sw.isOn?@"true":@"false";
}

-(void)didSelect{
    [super dispatchCellEventWithName:self.cellData[@"onClick"]];
}

@end
