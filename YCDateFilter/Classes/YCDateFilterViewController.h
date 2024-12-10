//
//  YCDateFilterViewController.h
//  YCDateFilter
//
//  Created by 杨超 on 2024/12/10.
//  Copyright © 2024 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCCommon.h"

NS_ASSUME_NONNULL_BEGIN

@interface YCDateFilterViewController : UIViewController

@property (nonatomic, copy) YCDateRangeBlock dateRangeBlock;

@end

NS_ASSUME_NONNULL_END
