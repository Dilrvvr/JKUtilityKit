//
//  UIColor+JKUtilityDynamic.h
//  JKUtilityKit
//
//  Created by albert on 2020/8/7.
//

#import <UIKit/UIKit.h>

@interface UIColor (JKUtilityDynamic)

/// 低于iOS13将直接返回lightColor
+ (UIColor *)jk_dynamicWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;
@end
