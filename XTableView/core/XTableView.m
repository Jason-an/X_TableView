#import "XTableView.h"

@interface XTableView()<UITableViewDataSource,UITableViewDelegate/*,UIScrollViewDelegate*/>

@property(nonatomic)NSMutableDictionary* blockDic;
@property(nonatomic)bool isClear;
@property(nonatomic)NSMutableArray* didScrollArr;
@property(nonatomic)NSMutableArray* didScrollStartArr;
@property(nonatomic)NSMutableArray* didScrollEndArr;
@property(nonatomic)NSMutableArray* didTouchUpArr;
@end



@implementation XTableView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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
    _blockDic = [[NSMutableDictionary alloc]init];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataSource = self;
    self.delegate = self;
}

-(void)addEventListerWithName:(enum XTableViewEvent)name block:(void(^)())block{
    
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
    return _xDataSource.count;
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

@end


