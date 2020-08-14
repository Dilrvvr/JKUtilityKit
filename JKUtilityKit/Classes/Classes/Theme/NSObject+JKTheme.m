//
//  NSObject+JKTheme.m
//  JKTheme
//
//  Created by albert on 2020/7/11.
//

#import "NSObject+JKTheme.h"
#import "JKThemeProvider.h"
#include <objc/runtime.h>

@implementation NSObject (JKTheme)

- (void)setJk_themeProvider:(JKThemeProvider *)darkModeProvider {
    
    if (darkModeProvider && ![darkModeProvider isKindOfClass:[JKThemeProvider class]]) { return; }
    
    objc_setAssociatedObject(self, @selector(jk_themeProvider), darkModeProvider, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JKThemeProvider *)jk_themeProvider {
    
    return objc_getAssociatedObject(self, _cmd);
}
@end
