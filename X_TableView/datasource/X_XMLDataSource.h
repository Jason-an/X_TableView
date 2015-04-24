#import <Foundation/Foundation.h>
#import "X_TableView.h"

@interface X_XMLDataSource : NSObject<X_TableViewDataSource>
+ (X_XMLDataSource *)xmlDataSourceWithFileName:(NSString*)filename;
@end
