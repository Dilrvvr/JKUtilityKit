//
//  NSObject+JKUtilityProperty.h
//  JKUtilityKit
//
//  Created by albert on 2020/8/14.
//

#import <Foundation/Foundation.h>

@interface NSObject (JKUtilityProperty)

/// iOS13获取对象属性 keyPath: 无下划线时会自动添加下划线
- (id)jk_getIvarValueForWithKeyPath:(NSString *)keyPath;
@end
