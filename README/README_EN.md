# YCDateFilter

[![CI Status](https://img.shields.io/travis/杨超/YCDateFilter.svg?style=flat)](https://travis-ci.org/杨超/YCDateFilter)
[![Version](https://img.shields.io/cocoapods/v/YCDateFilter.svg?style=flat)](https://cocoapods.org/pods/YCDateFilter)
[![License](https://img.shields.io/cocoapods/l/YCDateFilter.svg?style=flat)](https://cocoapods.org/pods/YCDateFilter)
[![Platform](https://img.shields.io/cocoapods/p/YCDateFilter.svg?style=flat)](https://cocoapods.org/pods/YCDateFilter)


- [中文](../README.md)
- English


## description
This component is used to select a month or date range

## Support
iPhone / iPad


## Installation

YCDateFilter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:


```ruby
pod 'YCDateFilter'
```

## Usage

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

<img src="../Example/YCDateFilter/demo.gif" width="300" height="639" alt="示例gif">

## Author

杨超, 1552612373@qq.com

## License

YCDateFilter is available under the MIT license. See the LICENSE file for more info.
