//
//  JKThemeProvider.m
//  JKTheme
//
//  Created by albert on 2020/7/7.
//

#import "JKThemeProvider.h"
#import "JKThemeManager.h"

@interface JKThemeProvider ()

/** handlerDictionary */
@property (nonatomic, strong) NSMutableDictionary *handlerDictionary;

/** handlerArray */
@property (nonatomic, strong) NSMutableArray *handlerArray;
@end

@implementation JKThemeProvider

+ (void)initialize {
    
    [JKThemeManager sharedManager];
}

#pragma mark
#pragma mark - Public Method

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
                        provideHandler:(JKThemeProvideHandler)provideHandler {
    
    if (!owner || ![owner conformsToProtocol:@protocol(JKThemeProviderProtocol)]) { return nil; }
    
    if (owner.jk_themeProvider) {
        
        [owner.jk_themeProvider addProvideHandlerForKey:handlerKey handler:provideHandler];
        
        return owner.jk_themeProvider;
    }
    
    JKThemeProvider *themeProvider = [JKThemeProvider new];
    
    [themeProvider setOwner:owner];
    
    owner.jk_themeProvider = themeProvider;
    
    [owner.jk_themeProvider addProvideHandlerForKey:handlerKey handler:provideHandler];
    
    return themeProvider;
}

/**
 * 创建一个JKThemeProvider实例
 * 自动将JKThemeBackgroundColorHandlerKey == @"backgroundColor"作为handlerKey
 */
+ (JKThemeProvider *)providerBackgroundColorWithOwner:(id <JKThemeProviderProtocol>)owner
                                       provideHandler:(JKThemeProvideHandler)provideHandler {
    
    return [self providerWithOwner:owner handlerKey:JKThemeBackgroundColorHandlerKey provideHandler:provideHandler];
}

/**
 * 创建一个JKThemeProvider实例
 * 自动将JKThemeTextColorHandlerKey == @"textColor"作为handlerKey
 */
+ (JKThemeProvider *)providerTextColorWithOwner:(id <JKThemeProviderProtocol>)owner
                                 provideHandler:(JKThemeProvideHandler)provideHandler {
    
    return [self providerWithOwner:owner handlerKey:JKThemeTextColorHandlerKey provideHandler:provideHandler];
}

/**
 * 添加一个处理主题变更的handler
 *
 * key : handler的缓存key，使用key可支持handler替换
 * handler : 切换皮肤后调用的block，赋值后将会立即执行一次
 */
- (void)addProvideHandlerForKey:(NSString *)key
                        handler:(JKThemeProvideHandler)handler {
    
    if (!handler || !self.owner) { return; }
    
    JKThemeProvideHandler previousHandler = nil;
    
    if ([key isKindOfClass:[NSString class]] &&
        key.length > 0) {
        
        previousHandler = [self.handlerDictionary objectForKey:key];
        
        [self.handlerDictionary setObject:handler forKey:key];
    }
    
    if (previousHandler &&
        [self.handlerArray containsObject:previousHandler]) {
        
        NSInteger index = [self.handlerArray indexOfObject:previousHandler];
        
        [self.handlerArray replaceObjectAtIndex:index withObject:handler];
        
    } else {
        
        [self.handlerArray addObject:handler];
    }
    
    handler(self, self.owner);
}

/**
 * 执行所有的handler
 */
- (void)executeAllProvideHandler {
    
    [self.handlerArray enumerateObjectsUsingBlock:^(JKThemeProvideHandler _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj(self, self.owner);
    }];
}

/**
 * 根据key获取某一handler
 */
- (JKThemeProvideHandler)provideHandlerForKey:(NSString *)key {
    
    if (![key isKindOfClass:[NSString class]] ||
        key.length <= 0) {
        
        return nil;
    }
    
    JKThemeProvideHandler handler = [self.handlerDictionary objectForKey:key];
    
    return handler;
}

/**
 * 根据key执行某一handler
 */
- (void)executeProvideHandlerForKey:(NSString *)key {
    
    if (![key isKindOfClass:[NSString class]] ||
        key.length <= 0) {
        
        return;
    }
    
    JKThemeProvideHandler handler = [self.handlerDictionary objectForKey:key];
    
    !handler ? : handler(self, self.owner);
}

/**
 * 根据key移除handler
 */
- (void)removeProvideHandlerForKey:(NSString *)key {
    
    if (!key) { return; }
    
    JKThemeProvideHandler handler = [self.handlerDictionary objectForKey:key];
    
    if (!handler) { return; }
    
    if ([self.handlerArray containsObject:handler]) {
        
        [self.handlerArray removeObject:handler];
    }
    
    [self.handlerDictionary removeObjectForKey:key];
}

/**
 * 移除所有handler
 */
- (void)clearAllProvideHandler {
    
    [self.handlerDictionary removeAllObjects];
    
    [self.handlerArray removeAllObjects];
}

#pragma mark
#pragma mark - Privete Method

- (void)themeDidChangeNotification:(NSNotification *)note {
    
    [self executeAllProvideHandler];
}

- (void)setOwner:(id<JKThemeProviderProtocol>)owner {
    
    _owner = owner;
}

#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:JKThemeDidChangeThemeNameNotification object:nil];
    }
    return self;
}

#pragma mark
#pragma mark - Private Property

- (NSMutableArray *)handlerArray {
    if (!_handlerArray) {
        _handlerArray = [NSMutableArray array];
    }
    return _handlerArray;
}

- (NSMutableDictionary *)handlerDictionary {
    if (!_handlerDictionary) {
        _handlerDictionary = [NSMutableDictionary dictionary];
    }
    return _handlerDictionary;
}
@end
