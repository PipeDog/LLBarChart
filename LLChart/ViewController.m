//
//  ViewController.m
//  LLChart
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 leiliang. All rights reserved.
//

#import "ViewController.h"
#import "LLBarChart.h"
#import "LLChart_config.h"

@interface ViewController () <LLBarChartDelegate> {
    LLBarChart *_barChart;
}

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = RGBColor(0xff9810);
    self.button.frame = CGRectMake(0, 0, 200, 40);
    [self.button setTitle:@"start animation" forState:UIControlStateNormal];
    self.button.bottom = self.view.bottom - 40;
    self.button.centerX = self.view.centerX;
    [self.button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];

    NSArray *xLabels = @[@"Python", @"iOS", @"Java", @"C", @"C++", @"Android"];
    NSArray *yLabels = @[@20, @40, @60, @80, @100];
    NSArray *dataArray = @[@0, @30, @38, @100, @90, @50];
    
    _barChart = [[LLBarChart alloc] initWithFrame:CGRectMake(30, 100, 300, 300) offset:CGSizeMake(10, 7)];
    _barChart.xLabels = xLabels;
    _barChart.yLabels = yLabels;
    _barChart.dataArray = dataArray;
    _barChart.ySuffix = @"人";
    _barChart.barWidth = 30;
    _barChart.barBlank = 30;
    _barChart.delegate = self;
    _barChart.needAnimation = YES;
    [self.view addSubview:_barChart];
}

- (void)handleButtonAction:(UIButton *)button {
    [_barChart startAnimateWithDuration:3.f completion:^{
        NSLog(@"%s", __FUNCTION__);
    }];
}

#pragma mark - LLBarChartDelegate
- (void)barChartDidSelected:(LLBarChart *)barChart bar:(LLBar *)bar {
    NSLog(@"bar : %@", bar);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你点击了bar" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

