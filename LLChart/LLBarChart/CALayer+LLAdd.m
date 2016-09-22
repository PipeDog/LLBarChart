//
//  CALayer+LLAdd.m
//  LLChart
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "CALayer+LLAdd.h"
#import <objc/runtime.h>
#import "LLChart_def.h"

@implementation CALayer (LLAdd)

YYSYNTH_DYNAMIC_PROPERTY_CTYPE(tag, setTag, NSInteger)

- (void)setTop:(CGFloat)t {
    self.frame = CGRectMake(self.left, t, self.width, self.height);
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)b {
    self.frame = CGRectMake(self.left, b - self.height, self.width, self.height);
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLeft:(CGFloat)l {
    self.frame = CGRectMake(l, self.top, self.width, self.height);
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)r {
    self.frame = CGRectMake(r - self.width, self.top, self.width, self.height);
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setWidth:(CGFloat)w {
    self.frame = CGRectMake(self.left, self.top, w, self.height);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)h {
    self.frame = CGRectMake(self.left, self.top, self.width, h);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)centerX {
    return self.position.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.position = CGPointMake(centerX, self.position.y);
}

- (CGFloat)centerY {
    return self.position.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.position = CGPointMake(self.position.x, centerY);
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.left, self.top, size.width, size.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}

@end
