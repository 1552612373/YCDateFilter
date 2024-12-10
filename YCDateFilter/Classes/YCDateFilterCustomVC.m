//
//  YCDateFilterCustomVC.m
//  YCDateFilter
//
//  Created by 杨超 on 2024/12/10.
//  Copyright © 2024 杨超. All rights reserved.
//

#import "YCDateFilterCustomVC.h"
#import "YCUnderlineButton.h"
#import <Masonry/Masonry.h>
#import "YCTools.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface YCDateFilterCustomVC ()

@property (nonatomic, strong) YCUnderlineButton *startDateButton;
@property (nonatomic, strong) YCUnderlineButton *endDateButton;

@property (nonatomic, strong) UILabel *toLabel;

@property (nonatomic, strong) UILabel *remindLabel;

@property (nonatomic, strong) UIDatePicker *myDatePicker;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end

@implementation YCDateFilterCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initDatas];
    [self initViews];
}

- (void)initDatas {
    self.startDateButton.choosed = YES;
    self.endDateButton.choosed = NO;
    
    self.startDate = [NSDate date];
    
    [self updateDate];
}

- (void)updateDate {
    if (self.startDate) {
        NSString *startStr = [YCTools getTimestampWithFormat:@"yyyy-MM-dd" date:self.startDate];
        [self.startDateButton setTitle:startStr forState:UIControlStateNormal];
    } else {
        [self.startDateButton setTitle:NSLocalizedString(@"开始时间", nil) forState:UIControlStateNormal];
    }
    
    if (self.endDate) {
        NSString *endStr = [YCTools getTimestampWithFormat:@"yyyy-MM-dd" date:self.endDate];
        [self.endDateButton setTitle:endStr forState:UIControlStateNormal];
    } else {
        [self.endDateButton setTitle:NSLocalizedString(@"结束时间", nil) forState:UIControlStateNormal];
    }
}

- (void)initViews {
    [self.view addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.height.equalTo(@44);
        make.bottom.equalTo(@(-30));
    }];
    
    [self.view addSubview:self.startDateButton];
    [self.startDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(self.view.mas_centerX).offset(-10);
        make.top.equalTo(@10);
        make.height.equalTo(@44);
    }];
    
    [self.view addSubview:self.endDateButton];
    [self.endDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(10);
        make.right.equalTo(@(-10));
        make.top.equalTo(@10);
        make.height.equalTo(@44);
    }];
    
    [self.view addSubview:self.toLabel];
    [self.toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startDateButton.mas_centerY);
        make.left.equalTo(self.startDateButton.mas_right);
        make.right.equalTo(self.endDateButton.mas_left);
    }];
    
    [self.view addSubview:self.remindLabel];
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.startDateButton.mas_bottom).offset(10);
    }];
    [self.remindLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [self.view addSubview:self.myDatePicker];
    [self.myDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.remindLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.sureButton.mas_top).offset(-30);
    }];
}

- (void)startClick {
    self.startDateButton.choosed = YES;
    self.endDateButton.choosed = NO;
    
    if (!self.startDate) {
        self.startDate = [NSDate date];
        [self updateDate];
    }
}

- (void)endClick {
    self.startDateButton.choosed = NO;
    self.endDateButton.choosed = YES;
    
    if (!self.endDate) {
        if (self.startDate) {
            self.endDate = self.startDate;
        } else {
            self.endDate = [NSDate date];
        }
        [self updateDate];
    }
}

- (void)pickerChanged:(UIDatePicker *)picker {
    NSLog(@"%@",picker.date);
    if (self.startDateButton.choosed == YES) {
        self.startDate = picker.date;
    } else {
        self.endDate = picker.date;
    }
    [self updateDate];
}

- (void)sureClick {
    if (self.startDate && self.endDate) {
        if ([self isIntervalMoreThanThirtyOneDays]) {
            // 超过31天
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = NSLocalizedString(@"选择的时间范围超过了31天，请缩小范围后重试", nil);
            hud.label.numberOfLines = 0;
            [hud hideAnimated:YES afterDelay:1.5];
            return;
        }
    }
    
    NSString *startTime = @"";
    NSString *endTime = @"";
    if (self.startDate && !self.endDate) {
        // 只选了开始日期
        NSString *startDateStr = [YCTools getTimestampWithFormat:@"yyyy-MM-dd" date:self.startDate];
        startTime = [NSString stringWithFormat:@"%@ 00:00:00",startDateStr];
        endTime = [NSString stringWithFormat:@"%@ 23:59:59",startDateStr];
        self.dateRangeBlock?self.dateRangeBlock(startTime,endTime, startDateStr):nil;
        return;
    }
    
    if (self.endDate && !self.startDate) {
        // 只选了结束日期
        NSString *startDateStr = [YCTools getTimestampWithFormat:@"yyyy-MM-dd" date:self.endDate];
        startTime = [NSString stringWithFormat:@"%@ 00:00:00",startDateStr];
        endTime = [NSString stringWithFormat:@"%@ 23:59:59",startDateStr];
        self.dateRangeBlock?self.dateRangeBlock(startTime,endTime, startDateStr):nil;
        return;
    }
    
    if (self.startDate && self.endDate) {
        // 选了开始日期和结束日期
        NSString *startDateStr = [YCTools getTimestampWithFormat:@"yyyy-MM-dd" date:self.startDate];
        NSString *endDateStr = [YCTools getTimestampWithFormat:@"yyyy-MM-dd" date:self.endDate];
        NSComparisonResult result = [self.startDate compare:self.endDate];
        if (result == NSOrderedDescending) {
            // 开始结束对调
            NSString *tempStr = @"";
            tempStr = startDateStr;
            startDateStr = endDateStr;
            endDateStr = tempStr;
        }
        startTime = [NSString stringWithFormat:@"%@ 00:00:00",startDateStr];
        endTime = [NSString stringWithFormat:@"%@ 23:59:59",endDateStr];
        NSString *showStr = @"";
        if ([startDateStr isEqualToString:endDateStr]) {
            showStr = startDateStr;
        } else {
            showStr = [NSString stringWithFormat:@"%@ %@ %@",startDateStr,NSLocalizedString(@"至", nil),endDateStr];
        }
        self.dateRangeBlock?self.dateRangeBlock(startTime,endTime, showStr):nil;
        return;
    }
    
    if (self.startDate && self.endDate) {
        // 开始日期和结束日期都没选，默认今天
        NSString *startDateStr = [YCTools getTimestampWithFormat:@"yyyy-MM-dd" date:[NSDate date]];
        startTime = [NSString stringWithFormat:@"%@ 00:00:00",startDateStr];
        endTime = [NSString stringWithFormat:@"%@ 23:59:59",startDateStr];
        self.dateRangeBlock?self.dateRangeBlock(startTime,endTime, startDateStr):nil;
        return;
    }
}

- (BOOL)isIntervalMoreThanThirtyOneDays {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Get the difference in days between start and end dates
    NSDateComponents *differenceComponents = [calendar components:NSCalendarUnitDay
                                                          fromDate:self.startDate
                                                            toDate:self.endDate
                                                           options:0];
    
    // Check if the difference is more than 31 days
    return ABS(differenceComponents.day) > 31;
}

#pragma get/set

- (YCUnderlineButton *)startDateButton {
    if (!_startDateButton) {
        _startDateButton = [YCUnderlineButton buttonWithType:UIButtonTypeCustom];
        _startDateButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_startDateButton addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startDateButton;
}

- (YCUnderlineButton *)endDateButton {
    if (!_endDateButton) {
        _endDateButton = [YCUnderlineButton buttonWithType:UIButtonTypeCustom];
        _endDateButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_endDateButton addTarget:self action:@selector(endClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endDateButton;
}

- (UILabel *)toLabel {
    if (!_toLabel) {
        _toLabel = [UILabel new];
        _toLabel.text = NSLocalizedString(@"至", nil);
        _toLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _toLabel;
}

- (UILabel *)remindLabel {
    if (!_remindLabel) {
        _remindLabel = [UILabel new];
        _remindLabel.text = NSLocalizedString(@"最长可查找时间跨度一个月的交易", nil);
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.textColor = UIColor.orangeColor;
        _remindLabel.font = [UIFont systemFontOfSize:13];
        _remindLabel.numberOfLines = 0;
    }
    return _remindLabel;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.backgroundColor = ZFMainColor;
        [_sureButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
        [_sureButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _sureButton.layer.cornerRadius = 6;
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (UIDatePicker *)myDatePicker {
    if (!_myDatePicker) {
        _myDatePicker = [UIDatePicker new];
        _myDatePicker.datePickerMode = UIDatePickerModeDate;
        
        _myDatePicker.maximumDate = [NSDate date];
        // 创建一个表示2015年1月1日的字符串
        NSString *dateString = @"2015-01-01";
        // 创建并配置 NSDateFormatter
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        // 将字符串转换为 NSDate
        NSDate *minDate = [formatter dateFromString:dateString];
        // 设置 minimumDate 属性
        _myDatePicker.minimumDate = minDate;
        
        [_myDatePicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
        
        if (@available(iOS 13.4, *)) {
            _myDatePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
    }
    return _myDatePicker;
}


@end
