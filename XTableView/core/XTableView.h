#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XTableViewEffect : NSObject
@end

@protocol XTableViewDataSource <NSObject>
-(NSUInteger)getCount;
@end

typedef NS_ENUM(NSInteger, XTableViewEvent) {
    XTableViewDidScroll,
    XTableViewWillReloadData,
    XTableViewDidReloadData,
};

@interface XTableView : UITableView
//dataSource and delegate are disabled
//@property(nonatomic,strong)id<XTableViewDataSource> xDataSource;
@property(nonatomic,strong)NSArray *xDataSource;
-(void)callEvent:(NSString *)key data:(NSMutableDictionary*)data;
-(void)addEventListener:(NSString*)name block:(void (^)(NSMutableDictionary* cellData))block;
-(void)addEventListerWithName:(enum XTableViewEvent)name block:(void(^)())block;
@end


@interface XTableViewCell : UITableViewCell
@property(nonatomic,weak) XTableView *xTableView;
@property(nonatomic) NSMutableDictionary *cellData;
-(void)initialize;
-(void)update;
-(void)didSelect;
-(CGFloat)getCellHeight;
-(void)callEvent:(NSString *)key;
@end
