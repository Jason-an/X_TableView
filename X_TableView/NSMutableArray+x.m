#import "NSMutableArray+x.h"
#import "X_TableView.h"

@interface X_XMLDataSource : NSObject
+ (NSMutableArray *)xmlDataSourceWithFileName:(NSString*)filename;
@end


@interface X_XMLDataSource()<NSXMLParserDelegate>{
    NSMutableArray *arr;
}
@end

@implementation X_XMLDataSource

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
    dic[CELL_TAG]=elementName;
    [arr addObject:dic];
    
}

-(NSUInteger)getCount{
    return arr.count;
}

-(NSMutableDictionary*)objectAtIndexedSubscript:(NSUInteger)index{
    return arr[index];
}


-(NSMutableArray*)loadXML:(NSString*)filename{
    arr = [[NSMutableArray alloc]init];
    NSData *data = [self readResData:filename];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    return arr;
}


+ (NSMutableArray *)xmlDataSourceWithFileName:(NSString*)filename{
    X_XMLDataSource *d = [[X_XMLDataSource alloc]init];
    return [d loadXML:filename];
}

@end




@implementation NSMutableArray(x)

+ (NSMutableArray *)x_ArrayWithXmlFile:(NSString*)filename{
    return [X_XMLDataSource xmlDataSourceWithFileName:filename];
}



-(NSMutableArray*)x_select:(NSString*)str where:(NSDictionary*)dic{
    
    NSMutableArray* arr=[[NSMutableArray alloc]init];
    
    for (int i=0; i<self.count; i++) {
        if ([self[i][CELL_TAG]isEqualToString:str]) {
            
            NSDictionary* ddd=self[i];
            bool b = YES;
            for (NSString *key in dic) {
                if ([dic[key] isEqualToString:ddd[key]]==NO) {
                    b=NO;
                    break;
                }
            }
            
            if (b) {
                [arr addObject:ddd];
            }
            
            
            
        }
    }
    
    return arr;
}

-(void)x_update:(NSString*)str where:(NSDictionary*)dic set:(NSDictionary*)dic2{
    NSArray* arr = [self x_select:str where:dic];
    
    for (NSMutableDictionary* d in arr){
        for (NSString* key in dic2){
            
            d[key] = dic2[key];
            
        }
    }
    
}





@end
