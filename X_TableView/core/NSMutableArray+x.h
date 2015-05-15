#import <Foundation/Foundation.h>

@interface NSMutableArray(x)


+(NSMutableArray*)x_ArrayWithXmlFile:(NSString*)filename;

//query
-(NSMutableArray*)x_select:(NSDictionary*)dic;
-(void)x_update:(NSDictionary*)dic set:(NSDictionary*)dic2;


@end
