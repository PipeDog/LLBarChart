//
//  UIColor+LLAdd.h
//  LLTools
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LLAdd)

+ (UIColor *)randomColor;

UIColor *RGBColor(NSInteger hexValue);

UIColor *RGBAColor(NSInteger hexValue, CGFloat alpha);

@end
