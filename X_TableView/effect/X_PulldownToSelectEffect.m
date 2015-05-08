#import "X_PulldownToSelectEffect.h"
#import "X_TableView.h"

@interface X_PulldownToSelectEffect()
@property(nonatomic)UIView *view;
@end

@implementation X_PulldownToSelectEffect


-(id)initWithItems:(NSArray*)items{
    self = [super init];
    if (self) {
        _view=[[UIView alloc]initWithFrame:CGRectMake(100, -50, 200, 50)];
        _view.backgroundColor=[UIColor grayColor];
    }
    return self;
}

-(void)onEffectAdd:(X_TableView *)xTableView{
    
    [xTableView insertSubview:_view atIndex:0];
    [xTableView addTableEventListenerWithId:self name:X_TableViewDidScroll block:^{
        
    }];
}

-(void)onEffectRemove:(X_TableView *)xTableView{
    [_view removeFromSuperview];
}


@end
