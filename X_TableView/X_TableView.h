#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#import "NSMutableArray+x.h"

extern const NSString* const CELL_TAG;

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

@interface X_TableView : UITableView

//dataSource and delegate are disabled
//it's not weak
//@property(nonatomic,strong)id<X_TableViewDataSource> xDataSource;
@property(nonatomic,strong)NSMutableArray *xDataSource;

//tableView event
//instead of KVO
-(void)addTableEventListenerWithId:(id)Id name:(enum X_TableViewEvent)name block:(void(^)())block;
-(void)removeTableEventWithId:(id)Id;

//cell event
-(void)addCellEventListenerWithName:(NSString*)name block:(void (^)(NSMutableDictionary* cellData))block;
-(void)dispatchCellEventWithName:(NSString *)name data:(NSMutableDictionary*)data;
-(void)removeAllCellEvent;

//effect
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
-(void)dispatchCellEventWithName:(NSString *)name;
@end
