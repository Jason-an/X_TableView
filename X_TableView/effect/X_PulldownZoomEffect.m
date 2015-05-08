#import "X_PulldownZoomEffect.h"
#import "X_TableView.h"

@interface X_PulldownZoomEffect()
@property(nonatomic)CGPoint offset;
@end

@implementation X_PulldownZoomEffect


-(void)onEffectAdd:(X_TableView *)xTableView{
    __weak X_TableView* weakTb = xTableView;
    //__weak PulldownZoomEffect* weakSelf = self;
    
    [weakTb addTableEventListenerWithId:self name:X_TableViewDidScroll block:^{
        CGFloat y = weakTb.contentOffset.y + weakTb.contentInset.top;//
        if (y<0) {
            X_TableViewCell *cell = (X_TableViewCell*)[weakTb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            if (cell!=nil) {
                CGFloat w = weakTb.frame.size.width;
                CGFloat h = [cell getCellHeight]-y;
                cell.frame = CGRectMake(0,y,w,h);
            }
        }
    }];
    /*
    [weakTb addTableEventListenerWithId:self name:XTableViewWillReloadData block:^{
        weakSelf.offset = weakTb.contentOffset;
    }];
    
    
    [weakTb addTableEventListenerWithId:self name:XTableViewDidReloadData block:^{
        weakTb.contentOffset = weakSelf.offset;
        aaa();
    }];*/
}

-(void)onEffectRemove:(X_TableView *)xTableView{
    
}




@end
