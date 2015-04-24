#import "XTableView.h"

@interface XTableView()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    NSMutableArray* _eventArr[10];
}
@property(nonatomic)NSMutableDictionary* blockDic;
@property(nonatomic)NSMutableDictionary* effectDic;
@end



@implementation XTableView

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
    
    for (int i=0; i<10; i++) {
        _eventArr[i]=[[NSMutableArray alloc]init];
    }
    
    _blockDic = [[NSMutableDictionary alloc]init];
    _effectDic = [[NSMutableDictionary alloc]init];

    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [super setDataSource:self];
    [super setDelegate:self];
}

-(void)addEventListerWithName:(enum XTableViewEvent)name block:(void(^)())block{
    [_eventArr[name]addObject:block];
}


-(void)addEffect:(id<XTableViewEffect>)effect{
    [effect onEffectAdd:self];
    _effectDic[[NSString stringWithFormat:@"%p",effect]]=effect;
}
-(void)removeEffect:(id<XTableViewEffect>)effect{
    [effect onEffectRemove:self];
    [_effectDic removeObjectForKey:[NSString stringWithFormat:@"%p",effect]];
}


-(void)addEventListener:(NSString*)name block:(void (^)(NSMutableDictionary* cellData))block{
    _blockDic[name]=block;
}

-(void)callEvent:(NSString *)key data:(NSMutableDictionary*)data{
    void(^callBack)(id)=self.blockDic[key];
    
    if (callBack!=nil) {
        callBack(data);
    }
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


- (XTableViewCell*)getCellWithTableView:(UITableView*)tbv tagName:(NSString*)tagName cellData:(NSMutableDictionary*)dic{
    
    NSString* cellName = [NSString stringWithFormat:@"%@Cell",[tagName capitalizedString]];
    XTableViewCell* cell = [tbv dequeueReusableCellWithIdentifier:cellName];
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
    
    XTableViewCell* cell = cellDic[cellName];
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
    XTableViewCell* cell = (XTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell didSelect];
}








-(void)eventCall:(enum XTableViewEvent)name{
    NSMutableArray *arr = _eventArr[name];
    for (void(^block)() in arr) {
        block();
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


