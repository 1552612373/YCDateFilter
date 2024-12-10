//
//  YCUnderlineButton.h
//  YCDateFilter
//
//  Created by 杨超 on 2024/12/10.
//  Copyright © 2024 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCUnderlineButton : UIButton

@property (nonatomic, assign) BOOL choosed;
@property (nonatomic, assign) BOOL unchoosedHideLine; // default NO  未选中的按钮是否要显示下划线

@property (nonatomic, strong) UIColor *choosedColor;
@property (nonatomic, strong) UIColor *unchoosedColor;


@property (nonatomic, strong, readonly) UIView *lineView;

@end

NS_ASSUME_NONNULL_END
