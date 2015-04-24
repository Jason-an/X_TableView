#import "XMLDataSource.h"

@interface XMLDataSource()<NSXMLParserDelegate>{
    NSMutableArray *arr;
}
@end

@implementation XMLDataSource

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
    dic[@"__tag__"]=elementName;
    [arr addObject:dic];
    
}

-(NSUInteger)getCount{
    return arr.count;
}

-(NSMutableDictionary*)objectAtIndexedSubscript:(NSUInteger)index{
    return arr[index];
}


-(void)loadXML:(NSString*)filename{
    arr = [[NSMutableArray alloc]init];
    NSData *data = [self readResData:filename];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
}


+ (XMLDataSource *)xmlDataSourceWithFileName:(NSString*)filename{
    XMLDataSource *d = [[XMLDataSource alloc]init];
    [d loadXML:filename];
    return d;
}

@end
