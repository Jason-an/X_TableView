#import "PulldownZoomEffect.h"
#import "XTableView.h"

@interface PulldownZoomEffect()
@property(nonatomic)CGPoint offset;
@end

@implementation PulldownZoomEffect

-(void)onInit:(XTableView*)tb{
    __weak XTableView* weakTb = tb;
    __weak PulldownZoomEffect* weakSelf = self;
    
    
    void(^aaa)()=^{
        CGFloat y = weakTb.contentOffset.y;
        
        if (y<0) {
            XTableViewCell *cell = (XTableViewCell*)[weakTb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            if (cell!=nil) {
                CGFloat w = tb.frame.size.width;
                CGFloat h = [cell getCellHeight]-y;
                cell.frame = CGRectMake(0,y,w,h);
            }
        }
    };
    
    [weakTb addEventListerWithName:XTableViewDidScroll block:aaa];
    
    [weakTb addEventListerWithName:XTableViewWillReloadData block:^{
        weakSelf.offset = weakTb.contentOffset;
    }];
    
    
    [weakTb addEventListerWithName:XTableViewDidReloadData block:^{
        weakTb.contentOffset = weakSelf.offset;
        aaa();
    }];
}


@end
