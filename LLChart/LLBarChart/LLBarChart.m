//
//  LLBarChart.m
//  LLChart
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 leiliang. All rights reserved.
//

#import "LLBarChart.h"
#import "LLBar.h"
#import "LLChart_config.h"

// bar tag
static NSInteger const k_bar_tag = 300000;
// 外部y轴最大值上方无标示部分高度
static CGFloat const k_top_blank_height = 40;
// 表格上下左右空白部分
static CGFloat const k_margin_top = 25.f;
static CGFloat const k_margin_left = 35.f;
static CGFloat const k_margin_bottom = 25.f;
static CGFloat const k_margin_right = 25.f;
// 默认bar宽及bar之间的间距
static CGFloat const k_default_bar_width = 17.f;
static CGFloat const k_default_bar_blank = 14.f;

@interface LLBarChart () <LLBarDelegate>

@property (nonatomic, strong, readwrite) CAGradientLayer *gradientLayer;
@property (nonatomic) CGSize offset;

@end

@implementation LLBarChart

- (instancetype)initWithFrame:(CGRect)frame offset:(CGSize)offset {
    self = [super initWithFrame:frame];
    if (self) {
        self.offset = offset;
        self.barWidth = k_default_bar_width;
        self.barBlank = k_default_bar_blank;
        self.ySuffix = @"";
        self.needAnimation = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawBackgroundLayer];
    [self drawAxis:rect];
    [self drawGraduation];
    [self drawBar];
}

#pragma mark - draw methods
// 添加渐变色背景
- (void)drawBackgroundLayer {
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = CGRectMake(0, 0, self.width, self.height);
    NSArray *colors = @[(__bridge id)RGBColor(0x14cbfc).CGColor,
                        (__bridge id)RGBColor(0x1ab9f9).CGColor,
                        (__bridge id)RGBColor(0x1c8cf4).CGColor];
    self.gradientLayer.colors = colors;
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 1);
    [self.layer addSublayer:self.gradientLayer];
}

// 绘制x轴及y轴（内外两条）
- (void)drawAxis:(CGRect)rect {
    // out
    CAShapeLayer *out_axisLayer = [self line];
    [self.layer addSublayer:out_axisLayer];
    
    UIBezierPath *out_axisPath = [UIBezierPath bezierPath];

    CGPoint out_left_top_point = CGPointMake(k_margin_left, k_margin_top);
    CGPoint out_origin_point = CGPointMake(k_margin_left, rect.size.height - k_margin_bottom);
    CGPoint out_right_bottom_point = CGPointMake(rect.size.width - k_margin_right, rect.size.height - k_margin_bottom);
    
    [out_axisPath moveToPoint:out_left_top_point];
    [out_axisPath addLineToPoint:out_origin_point];
    [out_axisPath addLineToPoint:out_right_bottom_point];
    [out_axisPath stroke];
    out_axisLayer.path = out_axisPath.CGPath;
    
    // int
    CAShapeLayer *int_axisLayer = [self line];
    int_axisLayer.lineDashPattern = @[@2, @2];
    [self.layer addSublayer:int_axisLayer];
    
    UIBezierPath *int_axisPath = [UIBezierPath bezierPath];
    
    CGPoint int_left_top_point = CGPointMake(k_margin_left + self.offset.width, k_margin_top);
    CGPoint int_origin_point = CGPointMake(k_margin_left + self.offset.width, rect.size.height - k_margin_bottom - self.offset.height);
    CGPoint int_right_bottom_point = CGPointMake(rect.size.width - k_margin_right, rect.size.height - k_margin_bottom - self.offset.height);
    
    [int_axisPath moveToPoint:int_left_top_point];
    [int_axisPath addLineToPoint:int_origin_point];
    [int_axisPath addLineToPoint:int_right_bottom_point];
    
    [int_axisPath moveToPoint:out_origin_point];
    [int_axisPath addLineToPoint:int_origin_point];
    
    [int_axisPath stroke];
    int_axisLayer.path = int_axisPath.CGPath;
}

// 绘制刻度
- (void)drawGraduation {
    // x轴刻度
    for (int i = 0; i < self.xLabels.count; i ++) {
        UILabel *label = [UILabel building:self backgroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:10] textColor:RGBColor(0xffffff) textAlignment:1 numberOfLines:1];
        label.text = self.xLabels[i];
        label.size = CGSizeMake(60, 14);
        label.centerX = k_margin_left + (i + 1) * (k_default_bar_blank + k_default_bar_width) - k_default_bar_width / 2;
        label.top = self.height - k_margin_bottom;
    }
    
    // y轴刻度
    for (int i = 0; i < self.yLabels.count; i ++) {
        UILabel *label = [UILabel building:self backgroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:10] textColor:RGBColor(0xffffff) textAlignment:2 numberOfLines:1];
        label.text = [NSString stringWithFormat:@"%@%@", self.yLabels[i], self.ySuffix];
        label.size = CGSizeMake(100, 20);
        label.right = k_margin_left - 2;
        label.centerY = self.height - k_margin_bottom - [self convertFrameFromValue:[self.yLabels[i] floatValue]];
    }
    
    // 绘制平行虚线
    CAShapeLayer *dashlineLayer = [CAShapeLayer layer];
    dashlineLayer.fillColor = [UIColor clearColor].CGColor;
    dashlineLayer.strokeColor = RGBColor(0xffffff).CGColor;
    dashlineLayer.lineCap = kCALineCapRound;
    dashlineLayer.lineJoin = kCALineJoinBevel;
    dashlineLayer.lineDashPattern = @[@2, @2];
    
    UIBezierPath *dashlinePath = [UIBezierPath bezierPath];
    
    for (int i = 0; i < self.yLabels.count; i ++) {
        CGFloat out_point_x = k_margin_left;
        CGFloat int_point_x = k_margin_left + self.offset.width;
        CGFloat end_point_x = self.height - k_margin_right;
        
        CGFloat out_point_y = self.height - k_margin_bottom - [self convertFrameFromValue:[self.yLabels[i] floatValue]];
        CGFloat int_point_y = out_point_y - self.offset.height;
        CGFloat end_point_y = int_point_y;
        
        [dashlinePath moveToPoint:CGPointMake(out_point_x, out_point_y)];
        [dashlinePath addLineToPoint:CGPointMake(int_point_x, int_point_y)];
        [dashlinePath addLineToPoint:CGPointMake(end_point_x, end_point_y)];
        [dashlinePath stroke];
    }

    dashlineLayer.path = dashlinePath.CGPath;
    [self.layer addSublayer:dashlineLayer];
}

// 绘制bar
- (void)drawBar {
    for (int i = 0; i < self.dataArray.count; i ++) {
        float barValue = [self.dataArray[i] floatValue];
        
        CGFloat left = k_margin_left + k_default_bar_blank + i * (k_default_bar_blank + k_default_bar_width);
        CGFloat top = self.height - k_margin_bottom - [self convertFrameFromValue:barValue];
        CGFloat width = k_default_bar_width;
        CGFloat height = [self convertFrameFromValue:barValue];
        LLBar *bar = [[LLBar alloc] initWithFrame:CGRectMake(left, top, width, height) offset:CGSizeMake(self.offset.width, self.offset.height)];
        bar.tag = k_bar_tag + i;
        bar.needAnimation = self.needAnimation;
        bar.delegate = self;
        [self addSubview:bar];
    }
}

#pragma mark - animation methods
- (void)startAnimate {
    for (int i = 0; i < self.dataArray.count; i ++) {
        LLBar *bar = [self viewWithTag:k_bar_tag + i];
        [bar startAnimate];
    }
}

- (void)startAnimateWithDuration:(NSTimeInterval)duration {
    for (int i = 0; i < self.dataArray.count; i ++) {
        LLBar *bar = [self viewWithTag:k_bar_tag + i];
        [bar startAnimateWithDuration:duration];
    }
}

- (void)startAnimateWithDuration:(NSTimeInterval)duration completion:(void (^ __nullable)())completion {
    dispatch_group_t animationGroup = dispatch_group_create();
    for (int i = 0; i < self.dataArray.count; i ++) {
        LLBar *bar = [self viewWithTag:k_bar_tag + i];
        dispatch_group_enter(animationGroup);
        [bar startAnimateWithDuration:duration completion:^{
            dispatch_group_leave(animationGroup);
        }];
    }
    dispatch_group_notify(animationGroup, dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

#pragma mark - factory methods
- (CAShapeLayer *)line {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = RGBColor(0xffffff).CGColor;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinBevel;
    layer.lineWidth = 0.5f;
    return layer;
}

#pragma mark - convert frame
// 外部y轴原点到标示最大值处的高度
- (CGFloat)maxYHeight {
    CGFloat max_frame_height = self.height - k_margin_top - k_margin_bottom - k_top_blank_height;
    return max_frame_height;
}

// value转换成frame
- (CGFloat)convertFrameFromValue:(float)value {
    CGFloat max_frame_height = [self maxYHeight];
    CGFloat max_value = self.yLabels.max;
    CGFloat result = max_frame_height * value / max_value;
    return result;
}

#pragma mark - LLBarDelegate
- (void)barDidSelected:(LLBar *)bar {
    if (self.delegate && [self.delegate respondsToSelector:@selector(barChartDidSelected:bar:)]) {
        [self.delegate barChartDidSelected:self bar:bar];
    }
}

@end
