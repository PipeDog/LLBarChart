//
//  LLBar.m
//  LLChart
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLBar.h"
#import "LLChart_config.h"

@interface LLBar () {
    CGFloat k_front_face_width;
    CGFloat k_right_face_width;
    CGFloat k_top_face_width;
    CGFloat k_front_face_height;
    CGFloat k_right_face_height;
    CGFloat k_top_face_height;
}

@property (nonatomic, strong, readwrite) CAGradientLayer *frontFace;
@property (nonatomic, strong, readwrite) CAGradientLayer *rightFace;
@property (nonatomic, strong, readwrite) CAGradientLayer *topFace;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation LLBar

- (instancetype)initWithFrame:(CGRect)frame offset:(CGSize)offset {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.needAnimation = NO;

        // face width and height
        k_front_face_width = frame.size.width;
        k_right_face_width = offset.width;
        k_top_face_width = frame.size.width + offset.width;
        k_front_face_height = frame.size.height;
        k_right_face_height = frame.size.height + offset.height;
        k_top_face_height = offset.height;

        // reset frame
        CGFloat origin_bottom = self.bottom;
        self.width = frame.size.width + offset.width;
        self.height = frame.size.height + offset.height;
        self.bottom = origin_bottom;
        
        self.frontFace = [CAGradientLayer layer];
        self.frontFace.width = k_front_face_width;
        self.frontFace.height = k_front_face_height;
        self.frontFace.left = 0;
        self.frontFace.bottom = self.height;
        [self.layer addSublayer:self.frontFace];
        
        self.rightFace = [CAGradientLayer layer];
        self.rightFace.width = k_right_face_width;
        self.rightFace.height = k_right_face_height;
        self.rightFace.left = self.frontFace.right;
        self.rightFace.bottom = self.height;
        [self.layer addSublayer:self.rightFace];

        self.topFace = [CAGradientLayer layer];
        self.topFace.width = k_top_face_width;
        self.topFace.height = k_top_face_height;
        self.topFace.left = self.frontFace.left;
        self.topFace.bottom = self.frontFace.top;
        [self.layer addSublayer:self.topFace];
        
        NSArray *colors = @[(__bridge id)RGBColor(0x54eacf).CGColor,
                            (__bridge id)RGBColor(0x56dfdd).CGColor,
                            (__bridge id)RGBColor(0x59d1ef).CGColor];

        self.frontFace.colors = [colors copy];
        self.rightFace.colors = [colors copy];
        self.topFace.colors = [colors copy];
        
        self.frontFace.startPoint = CGPointMake(0, 0);
        self.rightFace.startPoint = CGPointMake(0, 0);
        self.topFace.startPoint = CGPointMake(0, 0);
        
        self.frontFace.endPoint = CGPointMake(1, 1);
        self.rightFace.endPoint = CGPointMake(1, 1);
        self.topFace.endPoint = CGPointMake(1, 1);
    }
    return self;
}

// 绘制topFace及rightFace形状
- (void)draw {
    CAShapeLayer *right_mask_layer = [CAShapeLayer layer];
    right_mask_layer.lineWidth = 0.1f;
    right_mask_layer.lineCap = kCALineCapButt;
    right_mask_layer.lineJoin = kCALineJoinBevel;
    
    CGFloat const right_face_offset = k_top_face_height;
    
    UIBezierPath *right_lines_path = [UIBezierPath bezierPath];
    // move to rightFace left_bottom
    [right_lines_path moveToPoint:CGPointMake(0, self.rightFace.height)];
    // add line to rightFace right_bottom
    [right_lines_path addLineToPoint:CGPointMake(self.rightFace.width, self.rightFace.height - right_face_offset)];
    // add line to rightFace right_top
    [right_lines_path addLineToPoint:CGPointMake(self.rightFace.width, 0)];
    // add line to rightFace left_top
    [right_lines_path addLineToPoint:CGPointMake(0, right_face_offset)];
    // add line to rightFace left_bottom
    [right_lines_path addLineToPoint:CGPointMake(0, self.rightFace.height)];
    [right_lines_path closePath];
    right_mask_layer.path = right_lines_path.CGPath;
    
    self.rightFace.mask = right_mask_layer;
    
    CAShapeLayer *top_mask_layer = [CAShapeLayer layer];
    top_mask_layer.lineWidth = 0.1f;
    top_mask_layer.lineCap = kCALineCapButt;
    top_mask_layer.lineJoin = kCALineJoinBevel;
    
    CGFloat const top_face_offset = k_right_face_width;
    
    UIBezierPath *top_lines_path = [UIBezierPath bezierPath];
    // move to rightFace left_bottom
    [top_lines_path moveToPoint:CGPointMake(0, self.topFace.height)];
    // add line to rightFace right_bottom
    [top_lines_path addLineToPoint:CGPointMake(self.topFace.width - top_face_offset, self.topFace.height)];
    // add line to rightFace right_top
    [top_lines_path addLineToPoint:CGPointMake(self.topFace.width, 0)];
    // add line to rightFace left_top
    [top_lines_path addLineToPoint:CGPointMake(top_face_offset, 0)];
    // add line to rightFace left_bottom
    [top_lines_path addLineToPoint:CGPointMake(0, self.topFace.height)];
    [top_lines_path closePath];
    top_mask_layer.path = top_lines_path.CGPath;
    
    self.topFace.mask = top_mask_layer;
}

- (void)setNeedAnimation:(BOOL)needAnimation {
    _needAnimation = needAnimation;
    if (_needAnimation) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.frontFace.affineTransform = CGAffineTransformMakeTranslation(0, self.height + k_right_face_height);
        self.rightFace.affineTransform = CGAffineTransformMakeTranslation(0, self.height + k_right_face_height);
        self.topFace.affineTransform = CGAffineTransformMakeTranslation(0, self.height + k_right_face_height);
        [CATransaction commit];
    }
}

- (void)setDelegate:(id<LLBarDelegate>)delegate {
    _delegate = delegate;
    if (!self.tap) {
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        self.tap.numberOfTapsRequired = 1;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:self.tap];
    }
}

- (void)startAnimate {
    [self startAnimateWithDuration:2.f];
}

- (void)startAnimateWithDuration:(NSTimeInterval)duration {
    [self startAnimateWithDuration:duration completion:nil];
}

- (void)startAnimateWithDuration:(NSTimeInterval)duration completion:(void (^ __nullable)())completion {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.frontFace.affineTransform = CGAffineTransformMakeTranslation(0, self.height + k_right_face_height);
    self.rightFace.affineTransform = CGAffineTransformMakeTranslation(0, self.height + k_right_face_height);
    self.topFace.affineTransform = CGAffineTransformMakeTranslation(0, self.height + k_right_face_height);
    [CATransaction commit];

    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    self.frontFace.affineTransform = CGAffineTransformIdentity;
    self.rightFace.affineTransform = CGAffineTransformIdentity;
    self.topFace.affineTransform = CGAffineTransformIdentity;
    // .affineTransform = CGAffineTransformIdentity 赋值之后就已经执行成功
    // 回调时间提前
    // + (void)setCompletionBlock:(nullable void (^)(void))block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
    [CATransaction commit];
}

- (void)drawRect:(CGRect)rect {
    [self draw];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(barDidSelected:)]) {
        [self.delegate barDidSelected:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
