//
//  YCDateFilterView.m
//  YCDateFilter
//
//  Created by 杨超 on 2024/12/10.
//  Copyright © 2024 杨超. All rights reserved.
//

#import "YCDateFilterView.h"
#import <Masonry/Masonry.h>
#import "YCCommon.h"

@interface YCDateFilterView ()

@property (nonatomic, strong) UIView *whiteBgView;
@property (nonatomic, strong) UIView *vcView;

@property (nonatomic, strong) YCUnderlineButton *monthButton;
@property (nonatomic, strong) YCUnderlineButton *customButton;
@property (nonatomic, strong) UIView *lineView;


@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation YCDateFilterView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
//    self.backgroundColor = UIColor.clearColor;
    
    [self addSubview:self.whiteBgView];
    [self.whiteBgView addSubview:self.vcView];
    [self.whiteBgView addSubview:self.monthButton];
    [self.whiteBgView addSubview:self.customButton];
    [self.whiteBgView addSubview:self.closeButton];
    [self.whiteBgView addSubview:self.lineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
//        make.height.equalTo(@(kScreenHeight/2));
        make.height.equalTo(@400);
    }];
    
    [self.monthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(70, 50));
    }];
    
    [self.customButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.monthButton.mas_right).offset(5);
        make.centerY.equalTo(self.monthButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.centerY.equalTo(self.monthButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@0.5);
        make.top.equalTo(self.monthButton.mas_bottom);
    }];
    
    [self.vcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@60);
    }];
}

#pragma get/set

- (UIView *)whiteBgView {
    if (!_whiteBgView) {
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = UIColor.whiteColor;
    }
    return _whiteBgView;
}

- (UIView *)vcView {
    if (!_vcView) {
        _vcView = [UIView new];
    }
    return _vcView;
}

- (YCUnderlineButton *)monthButton {
    if (!_monthButton) {
        _monthButton = [YCUnderlineButton buttonWithType:UIButtonTypeCustom];
        [_monthButton setTitle:NSLocalizedString(@"月份", nil) forState:UIControlStateNormal];
        [_monthButton setTitleColor:ZFMainColor forState:UIControlStateNormal];
        _monthButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _monthButton.unchoosedHideLine = YES;
    }
    return _monthButton;
}

- (YCUnderlineButton *)customButton {
    if (!_customButton) {
        _customButton = [YCUnderlineButton buttonWithType:UIButtonTypeCustom];
        [_customButton setTitle:NSLocalizedString(@"自定义", nil) forState:UIControlStateNormal];
        [_customButton setTitleColor:ZFMainColor forState:UIControlStateNormal];
        _customButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _customButton.unchoosedHideLine = YES;
    }
    return _customButton;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    return _closeButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = ColorWithHex(0xcccccc);
    }
    return _lineView;
}

@end
