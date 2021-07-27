//
//  Utils.m
//  r2j
//
//  Created by Jools on 06/07/2021.
//

#import "Utils.h"

@implementation Utils

+ (NSString *) toJson:(NSString *) forKey withVal:(NSString *) withValue includeComma:(BOOL) comma
{
    return [NSString stringWithFormat:@"\"%@\": \"%@\"%@\n", forKey, withValue, comma ? @"," : @""];
}

+ (NSString *) toJson:(NSString *) forKey withIntVal:(int) withValue includeComma:(BOOL) comma
{
    return [NSString stringWithFormat:@"\"%@\": %i%@\n", forKey, withValue, comma ? @"," : @""];
}

+ (NSString *) toJson:(NSString *) forKey withFloatVal:(double) withValue includeComma:(BOOL) comma
{
    return [NSString stringWithFormat:@"\"%@\": %g%@\n", forKey, withValue, comma ? @"," : @""];
}
@end
