//
//  NSObject+JKUtilityProperty.m
//  JKUtilityKit
//
//  Created by albert on 2020/8/14.
//

#import "NSObject+JKUtilityProperty.h"
#import <objc/message.h>

@implementation NSObject (JKUtilityProperty)

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
