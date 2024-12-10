//
//  YCDateFilterMonthVC.m
//  YCDateFilter
//
//  Created by 杨超 on 2024/12/10.
//  Copyright © 2024 杨超. All rights reserved.
//

#import "YCDateFilterMonthVC.h"
#import <Masonry/Masonry.h>
#import "YCTools.h"

@interface YCDateFilterMonthVC ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *myPicker;

@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSMutableArray *currentMonthArray;

@property (nonatomic, assign) NSInteger currentYear;

@property (nonatomic, assign) NSInteger selectedYearIndex;
@property (nonatomic, assign) NSInteger selectedMonthIndex;

@property (nonatomic, strong) UIButton *sureButton;

@end

@implementation YCDateFilterMonthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initDatas];
    [self initViews];
}

- (void)initDatas {
    // 获取当前日期
    NSDate *currentDate = [NSDate date];
    // 使用 NSCalendar 获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 提取日期组件
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:currentDate];
    // 获取年份
    NSInteger currentYear = [components year];
    NSInteger currentMonth = [components month];
    
    self.currentYear = currentYear;

    for (int i = 1; i <= 12; i++) {
        [self.currentMonthArray addObject:@(i)];
        if (i == currentMonth) {
            break;
        }
    }
    
    
    for (int i = 0; i <= 10; i++) {
        NSNumber *year = @(currentYear - i);
        [self.yearArray addObject:year];
    }
    self.yearArray = [[self.yearArray reverseObjectEnumerator] allObjects].mutableCopy;
    
    for (int i = 1; i <= 12; i++) {
        [self.monthArray addObject:@(i)];
    }
    
    self.selectedYearIndex = self.yearArray.count-1;
    self.selectedMonthIndex = currentMonth-1;

}

- (void)initViews {
    [self.view addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.height.equalTo(@44);
        make.bottom.equalTo(@(-30));
    }];
    
    [self.view addSubview:self.myPicker];
    [self.myPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(self.sureButton.mas_top).offset(-30);
    }];
    
    [self.myPicker selectRow:self.selectedYearIndex inComponent:0 animated:NO];
    [self.myPicker selectRow:self.selectedMonthIndex inComponent:1 animated:NO];
    
}




- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *str = @"";
    if (component == 0) {
        str = [NSString stringWithFormat:@"%@",self.yearArray[row]];
    } else if (component == 1) {
        str = [NSString stringWithFormat:@"%@",self.monthArray[row]];
    }
    return str;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearArray.count;
    } else {
        if (self.selectedYearIndex == self.yearArray.count-1) {
            return self.currentMonthArray.count;
        }
        return self.monthArray.count;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"component %ld row %ld",component,row);
    if (component == 0) {
        self.selectedYearIndex = row;
    } else {
        self.selectedMonthIndex = row;
    }
}

- (void)sureClick {
    NSString *startTime = @"";
    NSString *endTime = @"";
    NSString *year = [NSString stringWithFormat:@"%@",self.yearArray[self.selectedYearIndex]];
    NSString *month = [NSString stringWithFormat:@"%@",self.monthArray[self.selectedMonthIndex]];
    if (month.length == 1) {
        month = [@"0" stringByAppendingString:month];
    }
    startTime = [NSString stringWithFormat:@"%@-%@-01 00:00:00",year,month];
    NSDate *nextMonthDate = [YCTools getLaterDateFromDate:[NSDate date] withYear:0 month:1 day:0];
    NSString *nextMonthString = [YCTools getTimestampWithFormat:@"yyyy-MM" date:nextMonthDate];
    endTime = [NSString stringWithFormat:@"%@-01 00:00:00",nextMonthString];
    
    NSString *showStr = [NSString stringWithFormat:@"%@-%@",year,month];
    self.dateRangeBlock?self.dateRangeBlock(startTime,endTime, showStr):nil;
}

#pragma get/set

- (UIPickerView *)myPicker {
    if (!_myPicker) {
        _myPicker = [UIPickerView new];
        _myPicker.delegate = self;
    }
    return _myPicker;
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

- (NSMutableArray *)yearArray {
    if (!_yearArray) {
        _yearArray = @[].mutableCopy;
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    if (!_monthArray) {
        _monthArray = @[].mutableCopy;
    }
    return _monthArray;
}

- (NSMutableArray *)currentMonthArray {
    if (!_currentMonthArray) {
        _currentMonthArray = @[].mutableCopy;
    }
    return _currentMonthArray;
}

@end
