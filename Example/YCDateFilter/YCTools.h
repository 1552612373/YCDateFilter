//
//  YCTools.h
//  YCDateFilter
//
//  Created by 杨超 on 2024/12/10.
//  Copyright © 2024 杨超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCTools : NSObject

/// 根据当前时间的计算前/后 几年几个月几日的时间
+ (NSDate *)getLaterDateFromDate:(NSDate *)date withYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

// 根据format和date，返回字符串
+ (NSString *)getTimestampWithFormat:(NSString *)format date:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
