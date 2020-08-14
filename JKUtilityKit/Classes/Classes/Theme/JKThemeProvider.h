//
//  JKThemeProvider.h
//  JKTheme
//
//  Created by albert on 2020/7/7.
//

#import <UIKit/UIKit.h>
#import "JKThemeUtility.h"

@class JKThemeProvider;

/// handler类型
typedef void(^JKThemeProvideHandler)(JKThemeProvider *provider, id providerOwner);

@interface JKThemeProvider : NSObject

/** owner */
@property (nonatomic, weak, readonly) NSObject <JKThemeProviderProtocol> *owner;

/**
 * 创建一个JKThemeProvider实例
 *
 * owner : JKThemeProvider实例的拥有者
 *         若owner已有JKThemeProvider实例，将不会创建新的实例而是将provideHandler添加至该实例
 * handlerKey : provideHandler的缓存可以，使用key可支持handler替换
 * provideHandler : 切换皮肤后调用的block，赋值后将会立即执行一次
 */
+ (JKThemeProvider *)providerWithOwner:(id <JKThemeProviderProtocol>)owner
                            handlerKey:(NSString *)handlerKey
                        provideHandler:(JKThemeProvideHandler)provideHandler;

/**
 * 创建一个JKThemeProvider实例
 * 自动将JKThemeBackgroundColorHandlerKey == @"backgroundColor"作为handlerKey
 */
+ (JKThemeProvider *)providerBackgroundColorWithOwner:(id <JKThemeProviderProtocol>)owner
                                       provideHandler:(JKThemeProvideHandler)provideHandler;

/**
 * 创建一个JKThemeProvider实例
 * 自动将@"textColor"作为handlerKey
 */
+ (JKThemeProvider *)providerTextColorWithOwner:(id <JKThemeProviderProtocol>)owner
                                 provideHandler:(JKThemeProvideHandler)provideHandler;

/**
 * 添加一个处理主题变更的handler
 *
 * key : handler的缓存key，使用key可支持handler替换
 * handler : 切换皮肤后调用的block，赋值后将会立即执行一次
 */
- (void)addProvideHandlerForKey:(NSString *)key
                        handler:(JKThemeProvideHandler)handler;

/**
 * 执行所有的handler
 */
- (void)executeAllProvideHandler;

/**
 * 根据key获取某一handler
 */
- (JKThemeProvideHandler)provideHandlerForKey:(NSString *)key;

/**
 * 根据key执行某一handler
 */
- (void)executeProvideHandlerForKey:(NSString *)key;

/**
 * 根据key移除handler
 */
- (void)removeProvideHandlerForKey:(NSString *)key;

/**
 * 移除所有handler
 */
- (void)clearAllProvideHandler;
@end
