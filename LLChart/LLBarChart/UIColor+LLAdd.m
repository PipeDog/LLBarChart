//
//  UIColor+LLAdd.m
//  LLTools
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "UIColor+LLAdd.h"

@implementation UIColor (LLAdd)

+ (UIColor *)randomColor {
    CGFloat r, g, b;
    r = arc4random() / (CGFloat)INT_MAX;
    g = arc4random() / (CGFloat)INT_MAX;
    b = arc4random() / (CGFloat)INT_MAX;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

UIColor *RGBColor(NSInteger hexValue) {
    return [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((CGFloat)(hexValue & 0xFF)) / 255.0 alpha:1.0];
}

UIColor *RGBAColor(NSInteger hexValue, CGFloat alpha) {
    return [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((CGFloat)(hexValue & 0xFF)) / 255.0 alpha:alpha];
}

@end
