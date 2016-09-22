//
//  CALayer+LLAdd.h
//  LLChart
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (LLAdd)

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) CGFloat top;

@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;

@end
