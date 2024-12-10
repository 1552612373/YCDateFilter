//
//  YCUnderlineButton.m
//  YCDateFilter
//
//  Created by 杨超 on 2024/12/10.
//  Copyright © 2024 杨超. All rights reserved.
//

#import "YCUnderlineButton.h"
#import <Masonry/Masonry.h>
#import "YCCommon.h"

@interface YCUnderlineButton ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation YCUnderlineButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    [self addSubview:self.lineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@3);
        make.right.equalTo(@(-3));
        make.bottom.equalTo(@0);
        make.height.equalTo(@2);
    }];
}

#pragma get/set

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = ZFMainColor;
        _lineView.layer.cornerRadius = 6;
    }
    return _lineView;
}

- (void)setChoosed:(BOOL)choosed {
    _choosed = choosed;
    

    if (choosed) {
        [self setTitleColor:ZFMainColor forState:UIControlStateNormal];
        self.lineView.hidden = NO;
        _lineView.backgroundColor = ZFMainColor;
    } else {
        if (self.unchoosedColor) {
            [self setTitleColor:self.unchoosedColor forState:UIControlStateNormal];
        } else {
            [self setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        }
        if (self.unchoosedHideLine) {
            self.lineView.hidden = YES;
        } else {
            self.lineView.hidden = NO;
            _lineView.backgroundColor = ColorWithHex(0x666666);
        }
    }
}


@end
