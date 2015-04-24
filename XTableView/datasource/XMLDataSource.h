#import <Foundation/Foundation.h>
#import "XTableView.h"

@interface XMLDataSource : NSObject<XTableViewDataSource>
+ (XMLDataSource *)xmlDataSourceWithFileName:(NSString*)filename;
@end
