//
//  JKUtility.h
//  Baisi
//
//  Created by albert on 16/3/13.
//  Copyright (c) 2016年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark
#pragma mark - 宏定义

/** 屏幕bounds */
#define JKScreenBounds ([UIScreen mainScreen].bounds)

/** 屏幕scale */
#define JKScreenScale ([UIScreen mainScreen].scale)

/** 屏幕宽度 */
#define JKScreenWidth ([UIScreen mainScreen].bounds.size.width)

/** 屏幕高度 */
#define JKScreenHeight ([UIScreen mainScreen].bounds.size.height)

/// 当前TabBar高度
#define JKCurrentTabBarHeight (JKUtility.isLandscape ? self.tabBarController.tabBar.frame.size.height : JKUtility.tabBarHeight)

// 快速设置颜色
#define JKColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define JKColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/** 系统蓝色 */
#define JKSystemBlueColor [UIColor colorWithRed:0.f green:122.0/255.0 blue:255.0/255.0 alpha:1]

/** 系统红色 */
#define JKSystemRedColor [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1]

// 随机色
#define JKRandomColor [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1]
#define JKRandomColorAlpha(a) [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:(a)]

// RGB相等颜色
#define JKSameRGBColor(rgb) [UIColor colorWithRed:(rgb)/255.0 green:(rgb)/255.0 blue:(rgb)/255.0 alpha:1]
#define JKSameRGBColorAlpha(rgb, a) [UIColor colorWithRed:(rgb)/255.0 green:(rgb)/255.0 blue:(rgb)/255.0 alpha:(a)]



#pragma mark
#pragma mark - 封装定时器

/// 停止定时器的block
typedef void(^JKStopTimerBlock)(void);

/**
 开启一个定时器，默认在dispatch_get_global_queue队里执行
 warning : 注意循环引用！！！
 
 @param target 定时器判断对象，若该对象销毁，定时器将自动销毁
 @param delay 延时执行时间
 @param timeInterval 执行间隔时间
 @param repeat 是否重复执行
 @param handler 重复执行事件
 */
JKStopTimerBlock JKDispatchTimer(id target, double delay, double timeInterval, BOOL repeat, void (^handler)(dispatch_source_t timer, void(^stopTimerBlock)(void)));

/**
 开启一个定时器
 warning : 注意循环引用！！！
 
 @param queue 定时器执行的队列
 @param target 定时器判断对象，若该对象销毁，定时器将自动销毁
 @param delay 延时执行时间
 @param timeInterval 执行间隔时间
 @param repeat 是否重复执行
 @param handler 重复执行事件
 */
JKStopTimerBlock JKDispatchTimerWithQueue(dispatch_queue_t queue, id target, double delay, double timeInterval, BOOL repeat, void (^handler)(dispatch_source_t timer, void(^stopTimerBlock)(void)));

#pragma mark
#pragma mark - JKUtility

@interface JKUtility : NSObject

/// 全局背景色 浅色模式 rgb 247
@property (class, nonatomic, readonly) UIColor *globalLightBackgroundColor;

/// 全局背景色 深色模式 rgb 24
@property (class, nonatomic, readonly) UIColor *globalDarkBackgroundColor;

/// 纯白色背景色
@property (class, nonatomic, readonly) UIColor *whiteBackgroundColor;

/// 纯黑色背景色
@property (class, nonatomic, readonly) UIColor *blackBackgroundColor;

/// 背景色 浅色模式 rgb254
@property (class, nonatomic, readonly) UIColor *lightBackgroundColor;

/// 背景色 深色模式 rgb 30
@property (class, nonatomic, readonly) UIColor *darkBackgroundColor;

/// 高亮背景色 浅色模式 rgb 229
@property (class, nonatomic, readonly) UIColor *highlightedLightBackgroundColor;

/// 高亮背景色 深色模式 rgb 37.5
@property (class, nonatomic, readonly) UIColor *highlightedDarkBackgroundColor;

/// 全局分隔线粗细 1.0 / [UIScreen mainScreen].scale
@property (class, nonatomic, readonly) CGFloat separatorLineThickness;

/// 全局分隔线背景色 浅色模式 rgb 217
@property (class, nonatomic, readonly) UIColor *separatorLineLightColor;

/// 全局分隔线背景色 深色模式 rgb 53
@property (class, nonatomic, readonly) UIColor *separatorLineDarkColor;

/// 是否X设备
@property (class, nonatomic, readonly) BOOL isDeviceX;

/// 是否iPad
@property (class, nonatomic, readonly) BOOL isDeviceiPad;

/// 当前是否横屏
@property (class, nonatomic, readonly) BOOL isLandscape;

/// 使用KVC获取当前的状态栏的view
@property (class, nonatomic, readonly) UIView *statusBarView;

/** keyWindow */
@property (class, nonatomic, readonly) UIWindow *keyWindow;

/// 获取keyWindow的safeAreaInsets
@property (class, nonatomic, readonly) UIEdgeInsets safeAreaInset;

/// 状态栏高度
@property (class, nonatomic, readonly) CGFloat statusBarHeight;

/// 导航条高度
@property (class, nonatomic, readonly) CGFloat navigationBarHeight;

/// tabBar高度
@property (class, nonatomic, readonly) CGFloat tabBarHeight;

/// 当前HomeIndicator高度
@property (class, nonatomic, readonly) CGFloat currentHomeIndicatorHeight;

/// 获取APP info.plist
@property (class, nonatomic, readonly) NSDictionary *appInfoDictionary;

/// 获取APP BundleID
@property (class, nonatomic, readonly) NSString *appBundleID;

/// 获取APP名称
@property (class, nonatomic, readonly) NSString *appName;

/// 获取APP版本号
@property (class, nonatomic, readonly) NSString *appVersion;

/// 获取APP build
@property (class, nonatomic, readonly) NSString *appBuild;

/// 跳转到设置
+ (void)jumpToSetting;

/// 检查URL
+ (NSURL *)checkValidURL:(id)url;

/// 在Safari中打开链接
+ (void)openURLInSafari:(id)url;

/// 让手机振动一下
+ (void)vibrateDevice;
@end

#pragma mark
#pragma mark - Category

@interface NSObject (JKUtility)

/// iOS13获取对象属性 keyPath: 无下划线时会自动添加下划线
- (id)jk_getIvarValueForWithKeyPath:(NSString *)keyPath;
@end
