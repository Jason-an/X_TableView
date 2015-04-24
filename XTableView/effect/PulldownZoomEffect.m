#import "PulldownZoomEffect.h"
#import "XTableView.h"

@interface PulldownZoomEffect()
@property(nonatomic)CGPoint offset;
@end

@implementation PulldownZoomEffect


-(void)onEffectAdd:(XTableView *)xTableView{
    __weak XTableView* weakTb = xTableView;
    //__weak PulldownZoomEffect* weakSelf = self;
    
    [weakTb addEventListerWithName:XTableViewDidScroll block:^{
        CGFloat y = weakTb.contentOffset.y + weakTb.contentInset.top;//
        if (y<0) {
            XTableViewCell *cell = (XTableViewCell*)[weakTb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
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

-(void)onEffectRemove:(XTableView *)xTableView{
    
}




@end
