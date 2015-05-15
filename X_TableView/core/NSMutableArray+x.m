#import "NSMutableArray+x.h"
#import "X_TableViewCellData_Key.h"

@interface __xxx__xml__ : NSObject
+ (NSMutableArray *)xmlDataSourceWithFileName:(NSString*)filename;
@end


@interface __xxx__xml__()<NSXMLParserDelegate>{
    NSMutableArray *arr;
}
@end

@implementation __xxx__xml__

-(NSString*)readRes:(NSString*)filename{
    return [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:nil] encoding:NSUTF8StringEncoding error:nil];
}

-(NSData*)readResData:(NSString*)filename{
    return [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:nil]];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"table"]) {
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
    dic[kCellTag]=elementName;
    [arr addObject:dic];
    
}

-(NSUInteger)getCount{
    return arr.count;
}

-(NSMutableDictionary*)objectAtIndexedSubscript:(NSUInteger)index{
    return arr[index];
}


-(NSMutableArray*)loadXML:(NSString*)filename{
    arr = [NSMutableArray new];
    NSData *data = [self readResData:filename];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    return arr;
}


+ (NSMutableArray *)xmlDataSourceWithFileName:(NSString*)filename{
    __xxx__xml__ *d = [__xxx__xml__ new];
    return [d loadXML:filename];
}

@end




@implementation NSMutableArray(x)

+ (NSMutableArray*)x_ArrayWithXmlFile:(NSString*)filename{
    return [__xxx__xml__ xmlDataSourceWithFileName:filename];
}



-(NSMutableArray*)x_select:(NSDictionary*)dic{
    
    NSMutableArray* arr=[NSMutableArray new];
    
    for (int i=0; i<self.count; i++) {
            
            NSMutableDictionary* d=self[i];
        
            bool b = YES;
            for (NSString *key in dic) {
                if ([dic[key] isEqual:d[key]]==NO) {
                    b=NO;
                    break;
                }
            }
            
            if (b) {
                [arr addObject:d];
            }
    }
    
    return arr;
}

-(void)x_update:(NSDictionary*)dic set:(NSDictionary*)dic2{
    NSMutableArray* arr = [self x_select:dic];
  
    for (NSMutableDictionary* d in arr){
        for (NSString* key in dic2){
            d[key] = dic2[key];
        }
    }
    
}





@end
