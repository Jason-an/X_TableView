#import <Foundation/Foundation.h>

@interface NSMutableArray(x)
+ (NSMutableArray *)x_ArrayWithXmlFile:(NSString*)filename;


//query
-(NSArray*)x_select:(NSString*)str where:(NSDictionary*)dic;
-(void)x_update:(NSString*)str where:(NSDictionary*)dic set:(NSDictionary*)dic2;
@end
