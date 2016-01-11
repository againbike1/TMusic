
#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
@end

@implementation NSArray (Log)

+ (NSMutableArray *)arrayWithPlaceCount:(NSInteger)count
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<count; i++) {
        [array addObject:@-1];
    }
    return array;
}

+ (NSInteger)getArrayCountWithArray:(NSMutableArray *)array
{
    NSInteger index = 0;
    for (id obj in array) {
        if (![obj isEqual:@-1]) {
            index++;
        }
    }
    return index;
}

+ (NSMutableArray *)getAllDataWithArray:(NSMutableArray *)array
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0 ; i < array.count; i++) {
        if (![array[i] isEqual:@-1]) {
            [tempArray addObject:array[i]];
        }
    }
    return tempArray;
}

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
@end