#import "X_PulldownZoomEffect.h"
#import "X_TableView.h"

@interface X_PulldownZoomEffect()
@property(nonatomic)CGPoint offset;
@end

@implementation X_PulldownZoomEffect


-(void)onEffectAdd:(X_TableView *)xTableView{
    __weak X_TableView* weakTb = xTableView;
    //__weak PulldownZoomEffect* weakSelf = self;
    
    [weakTb addEventListerWithName:XTableViewDidScroll block:^{
        CGFloat y = weakTb.contentOffset.y + weakTb.contentInset.top;//
        if (y<0) {
            X_TableViewCell *cell = (X_TableViewCell*)[weakTb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            if (cell!=nil) {
                
                //NSLog(@"[cell getCellHeight]=%.2f",[cell getCellHeight]);
                CGFloat w = weakTb.frame.size.width;
                CGFloat h = 44-y;
                cell.frame = CGRectMake(0,y,w,h);
            }
        }
    }];
    /*
    [weakTb addEventListerWithName:XTableViewWillReloadData block:^{
        weakSelf.offset = weakTb.contentOffset;
    }];
    
    
    [weakTb addEventListerWithName:XTableViewDidReloadData block:^{
        weakTb.contentOffset = weakSelf.offset;
        aaa();
    }];*/
}

-(void)onEffectRemove:(X_TableView *)xTableView{
    
}




@end
