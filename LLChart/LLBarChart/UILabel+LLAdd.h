//
//  UILabel+LLAdd.h
//  FastSchool
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LLAdd)

+ (UILabel *)building:(UIView *)superview backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines;

@end
