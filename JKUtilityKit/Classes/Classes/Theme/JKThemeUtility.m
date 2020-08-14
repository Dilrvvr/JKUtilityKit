//
//  JKThemeUtility.m
//  JKTheme
//
//  Created by albert on 2020/7/11.
//

#import "JKThemeUtility.h"

/** 浅色主题名称 */
NSString * const JKDefaultThemeLight = @"JKDefaultThemeLight";

/** 深色主题名称 */
NSString * const JKDefaultThemeDark = @"JKDefaultThemeDark";


/** 系统深色/浅色样式改变的通知 */
NSString * const JKThemeDidChangeThemeNameNotification = @"JKThemeDidChangeThemeNameNotification";

/** ThemeStyle改变的通知 */
NSString * const JKThemeDidChangeThemeStyleNotification = @"JKThemeDidChangeThemeStyleNotification";


/** 默认的背景色handlerKey */
NSString * const JKThemeBackgroundColorHandlerKey = @"backgroundColor";

/** 默认的字体颜色handlerKey */
NSString * const JKThemeTextColorHandlerKey = @"textColor";


#pragma mark
#pragma mark - 工具方法

@implementation JKThemeUtility

/// 获取keyWindow
+ (UIWindow *)keyWindow {
    
    UIWindow *keyWindow = nil;
    
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        
        keyWindow = [[UIApplication sharedApplication].delegate window];
        
    } else {
        
        NSArray *windows = [UIApplication sharedApplication].windows;
        
        for (UIWindow *window in windows) {
            
            if (window.hidden) { continue; }
            
            keyWindow = window;
            
            break;
        }
    }
    
    return keyWindow;
}
@end
