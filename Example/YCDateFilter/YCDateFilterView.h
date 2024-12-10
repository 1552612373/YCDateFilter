//
//  YCDateFilterView.h
//  YCDateFilter
//
//  Created by 杨超 on 2024/12/10.
//  Copyright © 2024 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCUnderlineButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface YCDateFilterView : UIView

@property (nonatomic, strong, readonly) UIView *vcView;

@property (nonatomic, strong, readonly) YCUnderlineButton *monthButton;
@property (nonatomic, strong, readonly) YCUnderlineButton *customButton;

@property (nonatomic, strong, readonly) UIButton *closeButton;

@end

NS_ASSUME_NONNULL_END
