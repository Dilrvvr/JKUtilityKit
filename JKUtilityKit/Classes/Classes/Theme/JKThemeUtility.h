//
//  JKThemeUtility.h
//  JKTheme
//
//  Created by albert on 2020/7/11.
//

#import <Foundation/Foundation.h>

#pragma mark
#pragma mark - Enum

typedef NS_ENUM(NSUInteger, JKThemeStyle) {
    
    /** 跟随系统 */
    JKThemeStyleSystem = 0,
    
    /** 浅色 */
    JKThemeStyleLight,
    
    /** 深色 */
    JKThemeStyleDark,
};

#pragma mark
#pragma mark - 宏定义




#pragma mark
#pragma mark - Notification & key

/** 浅色主题名称 */
UIKIT_EXTERN NSString * const JKDefaultThemeLight;

/** 深色主题名称 */
UIKIT_EXTERN NSString * const JKDefaultThemeDark;


/** 系统深色/浅色样式改变的通知 */
UIKIT_EXTERN NSString * const JKThemeDidChangeThemeNameNotification;

/** ThemeStyle改变的通知 */
UIKIT_EXTERN NSString * const JKThemeDidChangeThemeStyleNotification;


/** 默认的背景色handlerKey */
UIKIT_EXTERN NSString * const JKThemeBackgroundColorHandlerKey;

/** 默认的字体颜色handlerKey */
UIKIT_EXTERN NSString * const JKThemeTextColorHandlerKey;


#pragma mark
#pragma mark - Protocol

@class JKThemeProvider;

@protocol JKThemeProviderProtocol <NSObject>

@required

@property (nonatomic, strong) JKThemeProvider *jk_themeProvider;
@end


#pragma mark
#pragma mark - 工具方法

@interface JKThemeUtility : NSObject

/** keyWindow */
@property (class, nonatomic, readonly) UIWindow *keyWindow;
@end
