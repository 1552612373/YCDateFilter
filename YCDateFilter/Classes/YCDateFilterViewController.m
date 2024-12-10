//
//  YCDateFilterViewController.m
//  YCDateFilter
//
//  Created by 杨超 on 2024/12/10.
//  Copyright © 2024 杨超. All rights reserved.
//

#import "YCDateFilterViewController.h"
#import "YCDateFilterView.h"
#import "YCDateFilterMonthVC.h"
#import "YCDateFilterCustomVC.h"

@interface YCDateFilterViewController ()

@property (nonatomic, strong) YCDateFilterView *filterView;

@property (nonatomic, strong) YCDateFilterMonthVC *vc1;
@property (nonatomic, strong) YCDateFilterCustomVC *vc2;

@end

@implementation YCDateFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViews];
}

- (void)initViews {
    self.view = self.filterView;
    
    [self addChildViewController:self.vc1];
    [self addChildViewController:self.vc2];
    
    self.vc1.view.frame = self.filterView.vcView.bounds;
    self.vc2.view.frame = self.filterView.vcView.bounds;

    [self.filterView.vcView addSubview:self.vc1.view];
    [self.filterView.vcView addSubview:self.vc2.view];
    
    self.vc2.view.hidden = YES;
    
    [self monthClick];

}

- (void)closeClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)monthClick {
    self.vc1.view.hidden = NO;
    self.vc2.view.hidden = YES;
    self.filterView.monthButton.choosed = YES;
    self.filterView.customButton.choosed = NO;
}

- (void)customClick {
    self.vc1.view.hidden = YES;
    self.vc2.view.hidden = NO;
    self.filterView.monthButton.choosed = NO;
    self.filterView.customButton.choosed = YES;
}

#pragma get/set

- (YCDateFilterView *)filterView {
    if (!_filterView) {
        _filterView = [YCDateFilterView new];
        [_filterView.closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        [_filterView.monthButton addTarget:self action:@selector(monthClick) forControlEvents:UIControlEventTouchUpInside];
        [_filterView.customButton addTarget:self action:@selector(customClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filterView;
}

- (YCDateFilterMonthVC *)vc1 {
    if (!_vc1) {
        _vc1 = [YCDateFilterMonthVC new];
        @weakify(self);
        _vc1.dateRangeBlock = ^(NSString *startTime, NSString *endTime, NSString *showString) {
            @strongify(self);
            self.dateRangeBlock?self.dateRangeBlock(startTime, endTime, showString):nil;
            [self closeClick];
        };
    }
    return _vc1;
}

- (YCDateFilterCustomVC *)vc2 {
    if (!_vc2) {
        _vc2 = [YCDateFilterCustomVC new];
        @weakify(self);
        _vc2.dateRangeBlock = ^(NSString *startTime, NSString *endTime, NSString *showString) {
            @strongify(self);
            self.dateRangeBlock?self.dateRangeBlock(startTime, endTime, showString):nil;
            [self closeClick];
        };
    }
    return _vc2;
}

@end
