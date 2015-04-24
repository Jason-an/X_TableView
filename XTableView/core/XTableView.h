#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, XTableViewEvent) {
    XTableViewDidScroll,
    XTableViewWillReloadData,
    XTableViewDidReloadData,
};

@class XTableView;

@protocol XTableViewEffect<NSObject>
-(void)onEffectAdd:(XTableView *)xTableView;
-(void)onEffectRemove:(XTableView *)xTableView;
@end

@protocol XTableViewDataSource <NSObject>
-(NSUInteger)getCount;
-(NSMutableDictionary*)objectAtIndexedSubscript:(NSUInteger)index;
@end


@interface XTableView : UITableView

//dataSource and delegate are disabled
@property(nonatomic,strong)id<XTableViewDataSource> xDataSource;

-(void)callEvent:(NSString *)key data:(NSMutableDictionary*)data;
-(void)addEventListener:(NSString*)name block:(void (^)(NSMutableDictionary* cellData))block;
-(void)addEventListerWithName:(enum XTableViewEvent)name block:(void(^)())block;

-(void)addEffect:(id<XTableViewEffect>)effect;
-(void)removeEffect:(id<XTableViewEffect>)effect;
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
