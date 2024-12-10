//
//  YCTools.m
//  YCDateFilter
//
//  Created by 杨超 on 2024/12/10.
//  Copyright © 2024 杨超. All rights reserved.
//

#import "YCTools.h"

@implementation YCTools

/// 根据当前时间的计算前/后 几年几个月几日的时间
+ (NSDate *)getLaterDateFromDate:(NSDate *)date withYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    return newdate;
}

// 根据format和date，返回字符串
+ (NSString *)getTimestampWithFormat:(NSString *)format date:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    NSString *nowString = [df stringFromDate:date];
    return nowString;
}

// 获取图片
+ (UIImage *)getImageWithName:(NSString *)name suffix:(NSString *)suffix {
    NSString *imageName = name;
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSString *currentBundleName = currentBundle.infoDictionary[@"CFBundleName"];
    NSString *imagePath = [currentBundle pathForResource:imageName ofType:suffix inDirectory:[NSString stringWithFormat:@"%@.bundle",currentBundleName]];
    UIImage *imageFile = [UIImage imageWithContentsOfFile:imagePath];
    return imageFile;
}

@end
