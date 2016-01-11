#import <Foundation/Foundation.h>
#define MAX_ARRAY_COUNT 20
@interface NSArray (Log)

+ (NSMutableArray *)arrayWithPlaceCount:(NSInteger)count;

+ (NSInteger)getArrayCountWithArray:(NSMutableArray *)array;

+ (NSMutableArray *)getAllDataWithArray :(NSMutableArray *)array;

@end

@interface NSDictionary (Log)

@end