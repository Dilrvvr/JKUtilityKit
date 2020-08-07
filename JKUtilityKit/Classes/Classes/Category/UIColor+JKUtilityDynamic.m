//
//  UIColor+JKUtilityDynamic.m
//  JKUtilityKit
//
//  Created by albert on 2020/8/7.
//

#import "UIColor+JKUtilityDynamic.h"

@implementation UIColor (JKUtilityDynamic)

/// 低于iOS13将直接返回lightColor
+ (UIColor *)jk_dynamicWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    
    if (@available(iOS 13.0, *)) {
        
        UIColor *color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            
            if ([traitCollection userInterfaceStyle] != UIUserInterfaceStyleDark) {
                
                return lightColor;
            }

            return darkColor;
        }];
        
        return color;
        
    } else {
        
        return lightColor;
    }
}
@end
