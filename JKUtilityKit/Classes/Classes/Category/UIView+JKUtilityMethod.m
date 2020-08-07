//
//  UIView+JKUtilityMethod.m
//  JKUtilityKit
//
//  Created by albert on 2020/8/7.
//

#import "UIView+JKUtilityMethod.h"

@implementation UIView (JKUtilityMethod)

/// UIView截图
- (UIImage *)jk_snapshotImage {
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [[UIScreen mainScreen] scale]);
    
    //[view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return snapshot;
}
@end
