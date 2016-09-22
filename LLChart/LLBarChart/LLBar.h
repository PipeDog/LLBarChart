//
//  LLBar.h
//  LLChart
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LLBar;

@protocol LLBarDelegate <NSObject>

- (void)barDidSelected:(LLBar *)bar;

@end

@interface LLBar : UIView

- (instancetype)initWithFrame:(CGRect)frame offset:(CGSize)offset;

@property (nonatomic, weak) id <LLBarDelegate>delegate;

// 前、右、顶三个面，可以直接对这几个属性设置来更新颜色等
@property (nonatomic, strong, readonly) CAGradientLayer *frontFace;
@property (nonatomic, strong, readonly) CAGradientLayer *rightFace;
@property (nonatomic, strong, readonly) CAGradientLayer *topFace;
// 是否需要动画
@property (nonatomic, assign) BOOL needAnimation;

- (void)startAnimate;

- (void)startAnimateWithDuration:(NSTimeInterval)duration;

- (void)startAnimateWithDuration:(NSTimeInterval)duration completion:(void (^ __nullable)())completion;

@end

NS_ASSUME_NONNULL_END
