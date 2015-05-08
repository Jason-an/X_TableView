#import <UIKit/UIKit.h>
#import "X_TableView.h"

@interface TextfiledCell : X_TableViewCell

@end

@interface TextfiledCell()
@property(nonatomic)IBOutlet UIImageView *imgMark;
@property(nonatomic)IBOutlet UIView *imgContainer;
@property(nonatomic)IBOutlet UITextField *edtValue;
@property(nonatomic)IBOutlet UIView *valueContainer;
@end


@implementation TextfiledCell

- (void)update{
    
    UIColor *color = [UIColor grayColor];
    self.edtValue.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.cellData[kCellPlaceholder] attributes:@{NSForegroundColorAttributeName: color}];
    self.edtValue.text= self.cellData[kCellText];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)onEdit{
    self.cellData[kCellText] = self.edtValue.text;
}

@end
