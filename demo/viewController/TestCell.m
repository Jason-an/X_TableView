//
//  TestCell.m
//  demo
//
//  Created by EWT on 15/5/14.
//  Copyright (c) 2015年 zsbrother. All rights reserved.
//

#import "TestCell.h"
@interface TestCell()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end
@implementation TestCell
- (IBAction)test2:(id)sender {
    [self dispatchCellEventWithName:@"test2"];
}

-(void)xibDidLoad
{
    [super xibDidLoad];
    
}
- (IBAction)testTouched:(id)sender {
    [self dispatchCellEventWithName:@"testTouch"];
}
-(void)update
{
    self.testLabel.text = self.cellData[@"test"];
}

@end
