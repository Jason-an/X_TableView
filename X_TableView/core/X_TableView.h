#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "NSMutableArray+x.h"
#import "X_TableViewCellData_Key.h"


typedef NS_ENUM(NSUInteger, X_TableViewEvent) {
    X_TableViewDidScroll,
    X_TableViewWillReloadData,
    X_TableViewDidReloadData,
    X_TableViewDidSetFrame,
    X_TableViewDidLayoutSubviews,
};

@class X_TableView;
@class X_TableViewCell;

@protocol X_TableViewEffect<NSObject>
-(void)onEffectAdd:(X_TableView *)xTableView;
-(void)onEffectRemove:(X_TableView *)xTableView;
@end

@interface X_TableView : UITableView

//-------
//dataSource and delegate are disabled
//event instead of KVO

//-------------data-------------
@property(nonatomic,strong)NSMutableArray *xDataSource;
-(NSIndexPath*)indexToIndexPath:(NSInteger)index;

//-------------event-------------
//table event
-(void)addTableEventListenerWithId:(id)Id name:(X_TableViewEvent)name block:(void(^)())block;

//cell event
-(void)addCellEventListenerWithName:(NSString*)name block:(void (^)(X_TableViewCell* cell))block;
-(void)dispatchCellEventWithName:(NSString *)name data:(X_TableViewCell*)data;
-(void)removeAllCellEvent;

//other event
-(void)addCommitEditingEventWithBlock:(void(^)(UITableViewCellEditingStyle style,NSInteger index))block;

//-------------effect-------------
-(void)addEffect:(id<X_TableViewEffect>)effect;
-(void)removeEffect:(id<X_TableViewEffect>)effect;


@end

@interface X_TableViewController : UIViewController
@property(nonatomic)X_TableView* xTableView;
@end


@interface X_TableViewCell : UITableViewCell
@property(nonatomic,weak) X_TableView *xTableView;
@property(nonatomic) NSMutableDictionary *cellData;
-(void)xibDidLoad;
-(void)update;
-(void)didSelect;
-(CGFloat)getCellHeight;
-(void)dispatchCellEventWithName:(NSString *)name;
@end
