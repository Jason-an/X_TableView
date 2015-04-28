#import "X_TableView.h"

@interface X_TableView()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic)NSMutableDictionary* eventDic; // key --> string | value --> array{name:string,block:void(^)()}
@property(nonatomic)NSMutableDictionary* blockDic; // key --> string | value --> void (^)(NSMutableDictionary* cellData)
@property(nonatomic)NSMutableDictionary* effectDic;// key --> string | value --> id<X_TableViewEffect>
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

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self init2];
    }
    return self;
}

-(void)init2{
    
    _eventDic = [[NSMutableDictionary alloc]init];
    _blockDic = [[NSMutableDictionary alloc]init];
    _effectDic = [[NSMutableDictionary alloc]init];

    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [super setDataSource:self];
    [super setDelegate:self];
}

-(void)addTableEventListenerWithId:(id)Id name:(enum X_TableViewEvent)name block:(void(^)())block{
    NSString *key = [NSString stringWithFormat:@"%p",Id];
    if (_eventDic[key]==nil) {
        _eventDic[key]=[[NSMutableArray alloc]init];
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
    NSString *key = [NSString stringWithFormat:@"%p",effect];
    [effect onEffectRemove:self];
    [_effectDic removeObjectForKey:key];
}


-(void)addCellEventListenerWithName:(NSString*)name block:(void (^)(NSMutableDictionary* cellData))block{
    _blockDic[name]=block;
}

-(void)dispatchCellEventWithName:(NSString *)name data:(NSMutableDictionary*)data{
    void(^callBack)(id)=_blockDic[name];
    
    if (callBack!=nil) {
        callBack(data);
    }
}

-(void)removeAllCellEvent{
    [_blockDic removeAllObjects];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_xDataSource getCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self getCellWithTableView:tableView
                              tagName:_xDataSource[indexPath.row][@"__tag__"]
                             cellData:_xDataSource[indexPath.row]
            ];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


- (X_TableViewCell*)getCellWithTableView:(UITableView*)tbv tagName:(NSString*)tagName cellData:(NSMutableDictionary*)dic{
    
    NSString* cellName = [NSString stringWithFormat:@"%@Cell",[tagName capitalizedString]];
    X_TableViewCell* cell = [tbv dequeueReusableCellWithIdentifier:cellName];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil]firstObject];
        [cell initialize];
        cell.xTableView = self;
    }
    cell.cellData = dic;
    [cell update];
    return cell;
}


- (CGFloat)getCellHeightWithTagName:(NSString*)tagName andCellData:(NSMutableDictionary*)dic{
    
    NSString* cellName = [NSString stringWithFormat:@"%@Cell",[tagName capitalizedString]];
    
    
    static NSMutableDictionary *cellDic = nil;
    
    if (cellDic==nil) {
        cellDic = [[NSMutableDictionary alloc]init];
    }
    
    X_TableViewCell* cell = cellDic[cellName];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil]firstObject];
        [cell initialize];
        cell.xTableView = self;
        cellDic[cellName] = cell;
    }
    
    cell.cellData = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [cell update];
    return [cell getCellHeight];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getCellHeightWithTagName:_xDataSource[indexPath.row][@"__tag__"] andCellData:_xDataSource[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    X_TableViewCell* cell = (X_TableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell didSelect];
}


-(void)eventCall:(enum X_TableViewEvent)name{
    for (NSString *key in _eventDic) {
        for (NSDictionary *dic in _eventDic[key]) {
            if ([dic[@"name"] integerValue]==name) {
                ((void(^)())dic[@"block"])();
            }
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self eventCall:XTableViewDidScroll];
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
    [self eventCall:XTableViewWillReloadData];
    [super reloadData];
    [self eventCall:XTableViewDidReloadData];
}



@end


