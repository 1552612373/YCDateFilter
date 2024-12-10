//
//  YCCommon.h
//  YCDateFilter
//
//  Created by 杨超 on 2024/12/10.
//  Copyright © 2024 杨超. All rights reserved.
//

#ifndef YCCommon_h
#define YCCommon_h

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#define kScreenHeight                               [UIScreen mainScreen].bounds.size.height
#define kScreenWidth                                [UIScreen mainScreen].bounds.size.width

#define ColorWithHex(rgbValue)                     UIColor_FromRGBA(rgbValue,1.0)

#define ColorWithHexA(rgbValue, alpha)                     UIColor_FromRGBA(rgbValue,alpha)

#define UIColorRGBA(a, b, c, d)                            [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

#define UIColor_FromRGBA(rgbValue,A)                  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:A]




#define ZFMainColor ColorWithHex(0x5F4EF0)


typedef void(^YCDateRangeBlock)(NSString *startTime,NSString *endTime,NSString *showString);



#endif /* YCCommon_h */
