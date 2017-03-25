//
//  UIColor+Random.m
//  JTTitleView
//
//  Created by 王锦涛 on 2017/3/13.
//  Copyright © 2017年 JTWang. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+ (UIColor *)RandomColor
{
    CGFloat red = arc4random_uniform(256)/ 255.0;
    CGFloat green = arc4random_uniform(256)/ 255.0;
    CGFloat blue = arc4random_uniform(256)/ 255.0;
    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return color;
}
@end
