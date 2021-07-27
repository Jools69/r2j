//
//  Utils.h
//  r2j
//
//  Created by Jools on 06/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

+ (NSString *) toJson:(NSString *) forKey withVal:(NSString *) withValue includeComma:(BOOL) comma;
+ (NSString *) toJson:(NSString *) forKey withIntVal:(int) withValue includeComma:(BOOL) comma;
+ (NSString *) toJson:(NSString *) forKey withFloatVal:(double) withValue includeComma:(BOOL) comma;

@end

NS_ASSUME_NONNULL_END
