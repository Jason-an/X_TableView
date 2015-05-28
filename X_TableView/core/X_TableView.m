#import "X_TableView.h"

@interface X_TableView()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic)NSMutableDictionary* eventDic; // key --> string | value --> array{name:string,block:void(^)()}
@property(nonatomic)NSMutableDictionary* blockDic; // key --> string | value --> void (^)(NSMutableDictionary* cellData)
@property(nonatomic)NSMutableDictionary* effectDic;// key --> string | value --> id<X_TableViewEffect>
@property(nonatomic,copy)void(^commitEditingBlock)(UITableViewCellEditingStyle style,NSInteger index);
@end



@implementation X_TableView

-(id <UITableViewDataSource>)getDataSource{
    return nil;
}

-(void)setDataSource:(id <UITableViewDataSource>)dataSource{
}

-(id <UITableViewDelegate>)getDelegate{
    return nil;
}

-(void)setDelegate:(id <UITableViewDelegate>)delegate{
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self init2];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self init2];
    }
    return self;
}

-(void)init2{
    
    _eventDic = [NSMutableDictionary new];
    _blockDic = [NSMutableDictionary new];
    _effectDic = [NSMutableDictionary new];

    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [super setDataSource:self];
    [super setDelegate:self];
}

-(NSIndexPath*)indexToIndexPath:(NSInteger)index{
    return [NSIndexPath indexPathForRow:index inSection:0];
}

-(void)addTableEventListenerWithId:(id)Id name:(X_TableViewEvent)name block:(void(^)())block{
    NSString *key = [NSString stringWithFormat:@"%p",Id];
    if (_eventDic[key]==nil) {
        _eventDic[key]=[NSMutableArray new];
    }
    NSMutableArray *arr = _eventDic[key];
    [arr addObject:@{@"name":[NSNumber numberWithInteger:name],@"block":block}];
}

-(void)removeTableEventWithId:(id)Id{
    NSString *key = [NSString stringWithFormat:@"%p",Id];
    [_eventDic removeObjectForKey:key];
}


-(void)addEffect:(id<X_TableViewEffect>)effect{
    NSString *key = [NSString stringWithFormat:@"%p",effect];
    [effect onEffectAdd:self];
    _effectDic[key]=effect;
}
-(void)removeEffect:(id<X_TableViewEffect>)effect{
    [self removeTableEventWithId:effect];//////
    
    
    NSString *key = [NSString stringWithFormat:@"%p",effect];
    [effect onEffectRemove:self];
    [_effectDic removeObjectForKey:key];
}


-(void)addCellEventListenerWithName:(NSString*)name block:(void (^)(X_TableViewCell* cell))block{
    _blockDic[name]=block;
}

-(void)dispatchCellEventWithName:(NSString *)name data:(X_TableViewCell*)data{
    void(^callBack)(id)=_blockDic[name];
    
    if (callBack!=nil) {
        callBack(data);
    }
}

-(void)removeAllCellEvent{
    [_blockDic removeAllObjects];
}

-(void)addCommitEditingEventWithBlock:(void(^)(UITableViewCellEditingStyle style,NSInteger index))block{
    _commitEditingBlock = block;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _xDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSMutableDictionary* cellData = _xDataSource[indexPath.row];
    NSString* tagName = cellData[kCellTag];
    
    NSString* cellName = [self getCellNameWithTagName:tagName];
    X_TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil]firstObject];
        [cell xibDidLoad];
        cell.xTableView = self;
    }
    cell.cellData = cellData;
    [cell update];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(NSString*)getCellNameWithTagName:(NSString*)tagName{
    
    NSString *ch = [[tagName substringToIndex:1] uppercaseString];
    NSString *str = [tagName substringFromIndex:1];
    if ([str containsString:@"Cell"]) {
        return [NSString stringWithFormat:@"%@%@",ch,str];
    }
    return [NSString stringWithFormat:@"%@%@Cell",ch,str];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* cellData = _xDataSource[indexPath.row];
    NSString* tagName = cellData[kCellTag];
    
    NSString* cellName = [self getCellNameWithTagName:tagName];
    static NSMutableDictionary *cellDic = nil;
    
    if (cellDic==nil) {
        cellDic = [NSMutableDictionary new];
    }
    
    X_TableViewCell* cell = cellDic[cellName];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil]firstObject];
        [cell xibDidLoad];
        cell.xTableView = self;
        cellDic[cellName] = cell;
    }
    
    cell.cellData = [[NSMutableDictionary alloc] initWithDictionary:cellData];
    [cell update];
    return [cell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    X_TableViewCell* cell = (X_TableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell didSelect];
}


-(void)eventCall:(X_TableViewEvent)name{
    for (NSString *key in _eventDic) {
        for (NSDictionary *dic in _eventDic[key]) {
            if ([dic[@"name"] integerValue]==name) {
                ((void(^)())dic[@"block"])();
            }
        }
    }
}



-(void)layoutSubviews {
    [super layoutSubviews];
    [self eventCall:X_TableViewDidLayoutSubviews];
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self eventCall:X_TableViewDidSetFrame];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self eventCall:X_TableViewDidScroll];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    //didScrollStart
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //didScrollEnd
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerat{
    //didTouchUp
}

-(void)reloadData{
    [self eventCall:X_TableViewWillReloadData];
    [super reloadData];
    [self eventCall:X_TableViewDidReloadData];
}


//*
#pragma -mark UITableViewDelegate


// Display customization
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{}

// Variable height support

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{}

// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{}

// Section header & footer information. Views are preferred over title should you decide to provide both

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{}   // custom view for header. will be adjusted to default or specified header height
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{}   // custom view for footer. will be adjusted to default or specified footer height

// Accessories (disclosures).

//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{}
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{}

// Selection

// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{}

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{}
//- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{}
// Called after the user changes the selection.
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{}

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{}
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{}
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{}

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{}

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{}

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{}

// Indentation

//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{} // return 'depth' of row for hierarchies

// Copy/Paste.  All three methods must be implemented by the delegate.

//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{}
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{}




#pragma -mark UITableViewDataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{}



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{}
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{}

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *s=_xDataSource[indexPath.row][kCellCanEdit];
    if (s!=nil && [s isKindOfClass:[NSString class]]) {
        return [s boolValue];
    }
    return NO;
}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{}

// Index

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{}                                                  // return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{}  // tell table which section corresponds to section title/index (e.g. "B",1))

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_commitEditingBlock) {
        _commitEditingBlock(editingStyle,indexPath.row);
    }
}

// Data manipulation - reorder / moving support

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{}
//*/

@end


