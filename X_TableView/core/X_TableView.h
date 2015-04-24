#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, X_TableViewEvent) {
    XTableViewDidScroll,
    XTableViewWillReloadData,
    XTableViewDidReloadData,
};

@class X_TableView;

@protocol X_TableViewEffect<NSObject>
-(void)onEffectAdd:(X_TableView *)xTableView;
-(void)onEffectRemove:(X_TableView *)xTableView;
@end

@protocol X_TableViewDataSource <NSObject>
-(NSUInteger)getCount;
-(NSMutableDictionary*)objectAtIndexedSubscript:(NSUInteger)index;
@end


@interface X_TableView : UITableView

//dataSource and delegate are disabled
@property(nonatomic,strong)id<X_TableViewDataSource> xDataSource;

-(void)callEvent:(NSString *)key data:(NSMutableDictionary*)data;
-(void)addEventListener:(NSString*)name block:(void (^)(NSMutableDictionary* cellData))block;
-(void)addEventListerWithName:(enum X_TableViewEvent)name block:(void(^)())block;

-(void)addEffect:(id<X_TableViewEffect>)effect;
-(void)removeEffect:(id<X_TableViewEffect>)effect;
@end


@interface X_TableViewCell : UITableViewCell
@property(nonatomic,weak) X_TableView *xTableView;
@property(nonatomic) NSMutableDictionary *cellData;
-(void)initialize;
-(void)update;
-(void)didSelect;
-(CGFloat)getCellHeight;
-(void)callEvent:(NSString *)key;
@end
