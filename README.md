# YCDateFilter


[![Version](https://img.shields.io/cocoapods/v/YCDateFilter.svg?style=flat)](https://cocoapods.org/pods/YCDateFilter)
[![License](https://img.shields.io/cocoapods/l/YCDateFilter.svg?style=flat)](https://cocoapods.org/pods/YCDateFilter)
[![Platform](https://img.shields.io/cocoapods/p/YCDateFilter.svg?style=flat)](https://cocoapods.org/pods/YCDateFilter)


- 中文
- [English](README/README_EN.md)


## 描述
本组件用于选择月份或日期范围

## 支持
iPhone / iPad


## 安装

YCDateFilter支持[CocoaPods](https://cocoapods.org). 

要安装它，只需将以下行添加到您的Podfile中：

```ruby
pod 'YCDateFilter'
```

## 使用

```
@interface YCViewController ()

@property (nonatomic, strong) YCDateFilterViewController *filterVc;

@end
```

```
self.filterVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
// 选择器回调
self.filterVc.dateRangeBlock = ^(NSString *startTime, NSString *endTime, NSString *showString) {
    
};
[self presentViewController:self.filterVc animated:YES completion:nil];
    
```

<img src="Example/YCDateFilter/demo.gif" width="300" height="639" alt="示例gif">

## 作者

杨超, 1552612373@qq.com

## 许可证

YCDateFilter is available under the MIT license. See the LICENSE file for more info.
