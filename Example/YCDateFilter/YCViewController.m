//
//  YCViewController.m
//  YCDateFilter
//
//  Created by 杨超 on 12/10/2024.
//  Copyright (c) 2024 杨超. All rights reserved.
//

#import "YCViewController.h"
#import "YCDateFilterViewController.h"
#import "YCCommon.h"

@interface YCViewController ()

@property (nonatomic, strong) YCDateFilterViewController *filterVc;

@property (weak, nonatomic) IBOutlet UIButton *myButton;

@end

@implementation YCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (IBAction)buttonClick:(id)sender {
    
    self.filterVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    __weak UIButton *myButton = sender;
    self.filterVc.dateRangeBlock = ^(NSString *startTime, NSString *endTime, NSString *showString) {
        NSLog(@"%@ %@ %@",startTime,endTime,showString);
        [myButton setTitle:showString forState:UIControlStateNormal];
    };
    [self presentViewController:self.filterVc animated:YES completion:nil];
    
}


- (YCDateFilterViewController *)filterVc {
    if (!_filterVc) {
        _filterVc = [YCDateFilterViewController new];
    }
    return _filterVc;
}

@end
