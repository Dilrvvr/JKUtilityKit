//
//  JKThemeManager.m
//  JKTheme
//
//  Created by albert on 2020/7/10.
//

#import "JKThemeManager.h"
#include <objc/runtime.h>
#import "JKThemeUtility.h"

@interface JKThemeManager ()

@end

@implementation JKThemeManager

#pragma mark
#pragma mark - Public Method

/**
 * 单例对象
 */
+ (instancetype)sharedManager {
    
    static JKThemeManager *sharedManager_ = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedManager_ = [[self alloc] init];
    });
    
    return sharedManager_;
}

/**
 * 判断当前是否深色模式
 */
- (BOOL)checkIsDarkMode {
    
    BOOL isDark = NO;
    
    if (@available(iOS 13.0, *)) {
        
        if (self.autoSwitchDarkMode) {
            
            isDark = (UIUserInterfaceStyleDark == self.userInterfaceStyle);
            
            return isDark;
        }
    }
    
    isDark = [self.themeName isEqualToString:self.darkThemeName];
    
    return isDark;
}

- (void)setThemeStyle:(JKThemeStyle)themeStyle {
    
    // 无变化
    if (_themeStyle == themeStyle) { return; }
    
    _themeStyle = themeStyle;
    
    [self postThemeStyleDidChangeNotification];
    
    switch (themeStyle) {
        case JKThemeStyleSystem:
            if (@available(iOS 13.0, *)) {
                self.autoSwitchDarkMode = YES;
            }
            self.themeName = [[JKThemeManager sharedManager] checkIsDarkMode] ? self.darkThemeName : self.lightThemeName;
            break;
        case JKThemeStyleLight:
            if (@available(iOS 13.0, *)) {
                self.autoSwitchDarkMode = NO;
            }
            self.themeName = self.lightThemeName;
            break;
        case JKThemeStyleDark:
            if (@available(iOS 13.0, *)) {
                self.autoSwitchDarkMode = NO;
            }
            self.themeName = self.darkThemeName;
            break;
            
        default:
            break;
    }
}

- (void)setThemeName:(NSString *)themeName {
    
    if (!themeName ||
        ![themeName isKindOfClass:[NSString class]] ||
        themeName.length <= 0) {
        
        return;
    }
    
    // 主题名称无变化
    if ([_themeName isEqualToString:themeName]) {
        
        return;
    }
    
    _themeName = [themeName copy];
    
    [self postThemeDidChangeNotification];
}

- (void)setAutoSwitchDarkMode:(BOOL)autoSwitchDarkMode {
    _autoSwitchDarkMode = autoSwitchDarkMode;
    
    if (!_autoSwitchDarkMode) { return; }
    
    BOOL isDark = (UIUserInterfaceStyleDark == _userInterfaceStyle);
    
    NSString *themeName = isDark ? self.darkThemeName : self.lightThemeName;
    
    if (![self.themeName isEqualToString:themeName]) {
        
        self.themeName = themeName;
    }
}

#pragma mark
#pragma mark - Private Method

/// 发送themeStyle变化的通知
- (void)postThemeStyleDidChangeNotification {
    
    if (@available(iOS 13.0, *)) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:JKThemeDidChangeThemeStyleNotification object:@(self.themeStyle)];
    }
}

/// 发送themeName变化的通知
- (void)postThemeDidChangeNotification {
    
    UIWindow *keyWindow = JKThemeUtility.keyWindow;
    
    UIView *snapShotImageView = [keyWindow snapshotViewAfterScreenUpdates:NO];
    
    [keyWindow addSubview:snapShotImageView];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:JKThemeDidChangeThemeNameNotification object:self.themeName];
    
    if (@available(iOS 10.0, *)) {
        
        [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:0.25 delay:0 options:0 animations:^{
            
            snapShotImageView.alpha = 0;
            
        } completion:^(UIViewAnimatingPosition finalPosition) {
            
            [snapShotImageView removeFromSuperview];
        }];
        
    } else {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            snapShotImageView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [snapShotImageView removeFromSuperview];
        }];
    }
}

/// 监听系统样式变化
- (void)jk_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [[JKThemeManager sharedManager] jk_traitCollectionDidChange:previousTraitCollection];
    
    // 此时self类型为UIScreen
    if (@available(iOS 13.0, *)) {
        
        if ((UIScreen *)self != [UIScreen mainScreen]) { return; }
        
        BOOL appearanceChanged = [[UIScreen mainScreen].traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection];
        
        if (!appearanceChanged) { return; }
        
        [[JKThemeManager sharedManager] traitCollectionDidChangeUserInterfaceStyle];
    }
}

/// userInterfaceStyle改变
- (void)traitCollectionDidChangeUserInterfaceStyle {
    
    if (@available(iOS 13.0, *)) {
        
        _userInterfaceStyle = [UIScreen mainScreen].traitCollection.userInterfaceStyle;
        
        BOOL isDark = (UIUserInterfaceStyleDark == _userInterfaceStyle);
        
        if (!self.autoSwitchDarkMode) { return; }
        
        self.themeName = isDark ? self.darkThemeName : self.lightThemeName;
    }
}

/// 交换方法
+ (void)swizzleInstanceMethodWithOriginalClass:(Class)originalClass
                              originalSelector:(SEL)originalSelector
                                 swizzledClass:(Class)swizzledClass
                              swizzledSelector:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    
    // Method中包含IMP函数指针，通过替换IMP，使SEL调用不同函数实现
    // isAdd 返回值表示是否添加成功
    BOOL isAdd = class_addMethod(originalClass, originalSelector,
                                 method_getImplementation(swizzledMethod),
                                 method_getTypeEncoding(swizzledMethod));
    
    // class_addMethod : 如果发现方法已经存在，会失败返回，也可以用来做检查用,我们这里是为了避免源方法没有实现的情况;
    // 如果方法没有存在,我们则先尝试添加被替换的方法的实现
    if (isAdd) {
        
        class_replaceMethod(swizzledClass, swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        
        // 添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark
#pragma mark - Override

+ (void)load {
    
    // 交换UIScreen的 '- traitCollectionDidChange:' 来监听系统深色/浅色模式改变
    [self swizzleInstanceMethodWithOriginalClass:[UIScreen class] originalSelector:@selector(traitCollectionDidChange:) swizzledClass:[self class] swizzledSelector:@selector(jk_traitCollectionDidChange:)];
}

- (instancetype)init {
    if (self = [super init]) {
        
        if (@available(iOS 13.0, *)) {
            
            _userInterfaceStyle = [UIScreen mainScreen].traitCollection.userInterfaceStyle;
            
            self.autoSwitchDarkMode = YES;
            
            _themeName = (UIUserInterfaceStyleDark == _userInterfaceStyle) ? self.darkThemeName : self.lightThemeName;
        }
    }
    return self;
}

#pragma mark
#pragma mark - Property

- (NSString *)lightThemeName {
    if (!_lightThemeName) {
        _lightThemeName = JKDefaultThemeLight;
    }
    return _lightThemeName;
}

- (NSString *)darkThemeName {
    if (!_darkThemeName) {
        _darkThemeName = JKDefaultThemeDark;
    }
    return _darkThemeName;
}
@end
