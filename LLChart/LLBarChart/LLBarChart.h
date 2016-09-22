//
//  LLBarChart.h
//  LLChart
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LLBarChart;
@class LLBar;

@protocol LLBarChartDelegate <NSObject>

// 点击回调
- (void)barChartDidSelected:(LLBarChart *)barChart bar:(LLBar *)bar;

@end

@interface LLBarChart : UIView

/**
 * @brief init Method
 * @param offset offset.width y轴的偏移量
                 offset.height x轴的偏移量
 */
- (instancetype)initWithFrame:(CGRect)frame offset:(CGSize)offset;

// LLBarChartDelegate
@property (nonatomic, weak) id <LLBarChartDelegate>delegate;
// 渐变背景
@property (nonatomic, strong, readonly) CAGradientLayer *gradientLayer;
// x轴显示坐标内容(任意内容)
@property (nonatomic, strong) NSArray <NSString *>*xLabels;
// x轴显示坐标内容(具体值)
@property (nonatomic, strong) NSArray <NSNumber *>*yLabels;
// 数据源
@property (nonatomic, strong) NSArray <NSNumber *>*dataArray;
// y轴坐标后缀
@property (nonatomic, copy) NSString *ySuffix;
// bar宽度
@property (nonatomic, assign) CGFloat barWidth;
// bar之间的空隙
@property (nonatomic, assign) CGFloat barBlank;
// 是否需要动画显示(default is NO)
@property (nonatomic, assign) BOOL needAnimation;

/**
 * @brief 开始动画
 * @param duration 动画时间
 * @param completion 动画完成回调
 */
- (void)startAnimate;

- (void)startAnimateWithDuration:(NSTimeInterval)duration;

- (void)startAnimateWithDuration:(NSTimeInterval)duration completion:(void (^ __nullable)())completion;

@end

NS_ASSUME_NONNULL_END

