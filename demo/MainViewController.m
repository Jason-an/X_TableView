//
//  MainViewController.m
//  demo
//
//  Created by fc01 on 15/4/23.
//  Copyright (c) 2015年 zsbrother. All rights reserved.
//

#import "MainViewController.h"
#import "XTableView.h"

NSMutableDictionary* AA(NSDictionary *dic){
    return [[NSMutableDictionary alloc]initWithDictionary:dic];
}

@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"demo";
    
    
    
    XTableView *tbv = [[XTableView alloc]initWithFrame:CGRectZero];
    tbv.xDataSource = @[
        AA(@{@"__tag__":@"switch",@"text":@"switch test",@"select":@"true",@"onClick":@"d"}),
        AA(@{@"__tag__":@"basic",@"text":@"hello",@"onClick":@"a"}),
        AA(@{@"__tag__":@"basic",@"text":@"world",@"onClick":@"b"}),
        AA(@{@"__tag__":@"basic",@"text":@"hello",@"onClick":@"c"}),
        AA(@{@"__tag__":@"basic",@"text":@"world",@"onClick":@"d"}),
        
        AA(@{@"__tag__":@"switch",@"text":@"switch test",@"select":@"false",@"onClick":@"d"}),
        AA(@{@"__tag__":@"basic",@"text":@"hello",@"onClick":@"a"}),
        AA(@{@"__tag__":@"basic",@"text":@"world",@"onClick":@"b"}),
        AA(@{@"__tag__":@"basic",@"text":@"hello",@"onClick":@"c"}),
        AA(@{@"__tag__":@"basic",@"text":@"world",@"onClick":@"d"}),
                        ];
    
    [tbv addEventListener:@"a" block:^(NSMutableDictionary *cellData) {
        NSLog(@"aaaa");
    }];
    
    [tbv addEventListener:@"b" block:^(NSMutableDictionary *cellData) {
        NSLog(@"bbbb");
    }];
    
    [tbv addEventListener:@"c" block:^(NSMutableDictionary *cellData) {
        NSLog(@"cccc");
    }];
    
    [tbv addEventListener:@"d" block:^(NSMutableDictionary *cellData) {
        NSLog(@"dddd");
    }];
    
    self.view = tbv;
}

@end
