//
//  JKUtility.m
//  Baisi
//
//  Created by albert on 16/3/13.
//  Copyright (c) 2016年 albert. All rights reserved.
//

#import "JKUtility.h"
#import <AudioToolbox/AudioToolbox.h>
#import <objc/message.h>

#pragma mark
#pragma mark - 适配



#pragma mark
#pragma mark - 封装定时器

/**
 开启一个定时器，默认在dispatch_get_global_queue队里执行
 warning : 注意循环引用！！！
 
 @param target 定时器判断对象，若该对象销毁，定时器将自动销毁
 @param delay 延时执行时间
 @param timeInterval 执行间隔时间
 @param repeat 是否重复执行
 @param handler 重复执行事件
 */
JKStopTimerBlock JKDispatchTimer(id target, double delay, double timeInterval, BOOL repeat, void (^handler)(dispatch_source_t timer, void(^stopTimerBlock)(void))) {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    return JKDispatchTimerWithQueue(queue, target, delay, timeInterval, repeat, handler);
}

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
JKStopTimerBlock JKDispatchTimerWithQueue(dispatch_queue_t queue, id target, double delay, double timeInterval, BOOL repeat, void (^handler)(dispatch_source_t timer, void(^stopTimerBlock)(void))) {
    
    __block dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    uint64_t interval = (uint64_t)(timeInterval * NSEC_PER_SEC);
    
    dispatch_time_t delayTime = dispatch_walltime(NULL, (int64_t)(delay * NSEC_PER_SEC));
    
    dispatch_source_set_timer(timer, delayTime, interval, 0);
    
    JKStopTimerBlock stopTimerBlock = ^{
        
        if (!timer) { return; }
        
        dispatch_source_cancel(timer);
        
        timer = nil;
    };
    
    // 设置回调
    __weak __typeof(target) weakTarget = target;
    
    dispatch_source_set_event_handler(timer, ^{
        
        if (!timer) {
            
            NSLog(@"timer已销毁");
            
            return;
        }
        
        if (weakTarget)  {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (!timer) {
                    
                    NSLog(@"timer已销毁");
                    
                    return;
                }
                
                !handler ? : handler(timer, stopTimerBlock);
                
                if (repeat) { return; }
                    
                if (!timer) { return; }
                        
                dispatch_source_cancel(timer);
                
                timer = nil;
            });
            
        } else {

            NSLog(@"timer-->target已销毁");
                
            if (!timer) { return; }
            
            dispatch_source_cancel(timer);
            
            timer = nil;
        }
    });
    
    // 启动定时器
    dispatch_resume(timer);
    
    return stopTimerBlock;
}


@implementation JKUtility

/// 全局背景色 浅色模式 rgb 247
+ (UIColor *)globalLightBackgroundColor {
    
    return JKSameRGBColor(247.0);
}

/// 全局背景色 深色模式 rgb 24
+ (UIColor *)globalDarkBackgroundColor {
    
    return JKSameRGBColor(24.0);
}

/// 纯白色背景色
+ (UIColor *)whiteBackgroundColor {
    
    return [UIColor whiteColor];
}

/// 纯黑色背景色
+ (UIColor *)blackBackgroundColor {
    
    return [UIColor blackColor];
}

/// 背景色 浅色模式 rgb254
+ (UIColor *)lightBackgroundColor {
    
    return JKSameRGBColor(254.0);
}

/// 背景色 深色模式 rgb 30
+ (UIColor *)darkBackgroundColor {
    
    return JKSameRGBColor(30.0);
}

/// 高亮背景色 浅色模式 rgb 229
+ (UIColor *)highlightedLightBackgroundColor {
    
    return JKSameRGBColor(229.0);
}

/// 高亮背景色 深色模式 rgb 37.5
+ (UIColor *)highlightedDarkBackgroundColor {
    
    return JKSameRGBColor(37.5);
}

/// 全局分隔线粗细 1.0 / [UIScreen mainScreen].scale
+ (CGFloat)separatorLineThickness {
    
    static CGFloat separatorLineThickness_ = 0;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        separatorLineThickness_ = 1.0 / [UIScreen mainScreen].scale;
    });
    
    return separatorLineThickness_;
}

/// 全局分隔线背景色 浅色模式 rgb 217
+ (UIColor *)separatorLineLightColor {
    
    return JKSameRGBColor(217.0);
}

/// 全局分隔线背景色 深色模式 rgb 53
+ (UIColor *)separatorLineDarkColor {
    
    return JKSameRGBColor(53.0);
}

/// 是否X设备
+ (BOOL)isDeviceX {
    
    static BOOL isDeviceX_ = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (@available(iOS 11.0, *)) {
            
            if (!self.isDeviceiPad) {
                
                isDeviceX_ = self.keyWindow.safeAreaInsets.bottom > 0.0;
            }
        }
    });
    
    return isDeviceX_;
}

/// 是否iPad
+ (BOOL)isDeviceiPad {
    
    static BOOL isDeviceiPad_ = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        isDeviceiPad_ = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    });
    
    return isDeviceiPad_;
}

/// 当前是否横屏
+ (BOOL)isLandscape {
    
    return [UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height;
}

/// 使用KVC获取当前的状态栏的view
+ (UIView *)statusBarView {
    
    UIView *statusBar = nil;
    
    if (@available(iOS 13.0, *)) {
        
        
    } else {
        
        statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    }
    
    return statusBar;
}

/// keyWindow
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

/// 获取keyWindow的safeAreaInsets
+ (UIEdgeInsets)safeAreaInset {
    
    UIEdgeInsets safeAreaInset = UIEdgeInsetsZero;
    
    if (@available(iOS 11.0, *)) {
        
        safeAreaInset = self.keyWindow.safeAreaInsets;
    }
    
    return safeAreaInset;
}

/// 状态栏高度
+ (CGFloat)statusBarHeight {
    
    return self.isDeviceX ? 44.f : 20.f;
}

/// 导航条高度
+ (CGFloat)navigationBarHeight {
    
    if (self.isDeviceiPad) { // iPad
        
        return self.isLandscape ? 70.f : 64.f;
        
    } else { // iPhone
        
        return self.isLandscape ? (self.isDeviceX ? 44.f : 32.f) : (self.isDeviceX ? 88.f : 64.f);
    }
}

/// tabBar高度
+ (CGFloat)tabBarHeight {
    
    return (self.isDeviceX ? 49.f + 34.f : 49.f);
}

/// 当前HomeIndicator高度
+ (CGFloat)currentHomeIndicatorHeight {
    
    return self.isDeviceX ? (self.isLandscape ? 21.0 : 34.0) : 0.0;
}

/// 获取APP info.plist
+ (NSDictionary *)appInfoDictionary {
    
    return [[NSBundle mainBundle] infoDictionary];
}

/// 获取APP BundleID
+ (NSString *)appBundleID {
    
    return ([self.appInfoDictionary objectForKey:@"CFBundleIdentifier"]);
}

/// 获取APP名称
+ (NSString *)appName {
    
    return [self.appInfoDictionary objectForKey:@"CFBundleDisplayName"];
}

/// 获取APP版本号
+ (NSString *)appVersion {
    
    return [self.appInfoDictionary objectForKey:@"CFBundleShortVersionString"];
}

/// 获取APP build
+ (NSString *)appBuild {
    
    return [self.appInfoDictionary objectForKey:@"CFBundleVersion"];
}

/// 跳转到设置
+ (void)jumpToSetting {
    
    NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        
        [[UIApplication sharedApplication] openURL:URL];
    }
}

/// 检查URL
+ (NSURL *)checkValidURL:(id)url {
    
    if (!url) { return nil; }
    
    NSURL *URL = nil;
    
    if ([url isKindOfClass:[NSURL class]]) {
        
        URL = url;
        
    } else if ([url isKindOfClass:[NSString class]] &&
               [url length] > 0) {
        
        URL = [NSURL URLWithString:url];
    }
    
    return URL;
}

/// 在Safari中打开链接
+ (void)openURLInSafari:(id)url {
    
    NSURL *URL = [self checkValidURL:url];
    
    if (!URL) { return; }
    
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        
        [[UIApplication sharedApplication] openURL:URL];
    }
}

/// 让手机振动一下
+ (void)vibrateDevice {
    
    // iPad没有震动
    if (self.isDeviceiPad) { return; }
    
    // 普通短震，3D Touch 中 Peek 震动反馈
    //AudioServicesPlaySystemSound(1519);
    
    // 普通短震，3D Touch 中 Pop 震动反馈
    //AudioServicesPlaySystemSound(1520);
    
    // 连续三次短震
    //AudioServicesPlaySystemSound(1521);
    
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    if (@available(iOS 10.0, *)) {
        
        UIImpactFeedbackGenerator *feedbackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        
        [feedbackGenertor impactOccurred];
    }
}
@end


@implementation NSObject (JKUtility)

/// iOS13获取对象属性 keyPath: 无下划线时会自动添加下划线
- (id)jk_getIvarValueForWithKeyPath:(NSString *)keyPath {
    
    if (!keyPath ||
        ![keyPath isKindOfClass:[NSString class]]) {
        
        return nil;
    }
    
    id object = nil;
    
    if (@available(iOS 13.0, *)) {
        
        if (![keyPath hasPrefix:@"_"]) {
            
            keyPath = [@"_" stringByAppendingString:keyPath];
        }
        
        Ivar ivar = class_getInstanceVariable([self class], [keyPath UTF8String]);
        
        object = object_getIvar(self, ivar);
        
    } else {
        
        object = [self valueForKeyPath:keyPath];
    }
    
    return object;
}

@end
