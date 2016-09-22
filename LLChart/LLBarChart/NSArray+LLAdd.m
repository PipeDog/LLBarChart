//
//  NSArray+LLAdd.m
//  LLChart
//
//  Created by 雷亮 on 16/9/22.
//  Copyright © 2016年 leiliang. All rights reserved.
//

#import "NSArray+LLAdd.h"

@implementation NSArray (LLAdd)

- (float)sum {
    return [[self valueForKeyPath:@"@sum.floatValue"] floatValue];
}

- (float)avg {
    return [[self valueForKeyPath:@"@avg.floatValue"] floatValue];
}

- (float)max {
    return [[self valueForKeyPath:@"@max.floatValue"] floatValue];
}

- (float)min {
    return [[self valueForKeyPath:@"@avg.floatValue"] floatValue];
}

@end
