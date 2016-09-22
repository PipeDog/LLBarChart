//
//  UILabel+LLAdd.m
//  FastSchool
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "UILabel+LLAdd.h"

@implementation UILabel (LLAdd)

+ (UILabel *)building:(UIView *)superview backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines {
    UILabel *label = [[UILabel alloc] init];
    [superview addSubview:label];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    label.backgroundColor = backgroundColor ?: superview.backgroundColor;
    return label;
}

@end
