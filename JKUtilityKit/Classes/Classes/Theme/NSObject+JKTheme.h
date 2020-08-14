//
//  NSObject+JKTheme.h
//  JKTheme
//
//  Created by albert on 2020/7/11.
//

#import <Foundation/Foundation.h>
#import "JKThemeUtility.h"

@class JKThemeProvider;

@interface NSObject (JKTheme) <JKThemeProviderProtocol>

@property (nonatomic, strong) JKThemeProvider *jk_themeProvider;
@end
