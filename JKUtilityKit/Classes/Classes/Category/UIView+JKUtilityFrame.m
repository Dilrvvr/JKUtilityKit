//
//  UIView+JKUtilityFrame.m
//  JKUtilityKit
//
//  Created by albert on 2020/8/7.
//

#import "UIView+JKUtilityFrame.h"

@implementation UIView (JKUtilityFrame)

- (void)setJk_x:(CGFloat)jk_x {
    
    CGRect frame = self.frame;
    frame.origin.x = jk_x;
    self.frame = frame;
}

- (CGFloat)jk_x {
    
    return self.frame.origin.x;
}

- (void)setJk_left:(CGFloat)jk_left {
    
    [self setJk_x:jk_left];
}

- (CGFloat)jk_left {
    
    return [self jk_x];
}



- (void)setJk_y:(CGFloat)jk_y {
    
    CGRect frame = self.frame;
    frame.origin.y = jk_y;
    self.frame = frame;
}

- (CGFloat)jk_y {
    
    return self.frame.origin.y;
}

- (void)setJk_top:(CGFloat)jk_top {
    
    [self setJk_y:jk_top];
}

- (CGFloat)jk_top {
    
    return [self jk_y];
}



- (void)setJk_origin:(CGPoint)jk_origin {
    
    CGRect frame = self.frame;
    frame.origin = jk_origin;
    self.frame = frame;
}

- (CGPoint)jk_origin {
    
    return self.frame.origin;
}



- (void)setJk_width:(CGFloat)jk_width {
    
    CGRect frame = self.frame;
    frame.size.width = jk_width;
    self.frame = frame;
}

- (CGFloat)jk_width {
    
    return self.frame.size.width;
}

- (void)setJk_height:(CGFloat)jk_height {
    
    CGRect frame = self.frame;
    frame.size.height = jk_height;
    self.frame = frame;
}

- (CGFloat)jk_height {
    
    return self.frame.size.height;
}

- (void)setJk_size:(CGSize)jk_size {
    
    CGRect frame = self.frame;
    frame.size = jk_size;
    self.frame = frame;
}

- (CGSize)jk_size {
    
    return self.frame.size;
}



- (void)setJk_maxX:(CGFloat)jk_maxX {
    
    CGRect frame = self.frame;
    frame.origin.x = jk_maxX - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)jk_maxX {
    
    return CGRectGetMaxX(self.frame);
}

- (void)setJk_right:(CGFloat)jk_right {
    
    [self setJk_maxX:jk_right];
}

- (CGFloat)jk_right {
    
    return [self jk_maxX];
}



- (void)setJk_maxY:(CGFloat)jk_maxY {
    
    CGRect frame = self.frame;
    frame.origin.y = jk_maxY - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)jk_maxY {
    
    return CGRectGetMaxY(self.frame);
}

- (void)setJk_bottom:(CGFloat)jk_bottom {
    
    [self setJk_maxY:jk_bottom];
}

- (CGFloat)jk_bottom {
    
    return [self jk_maxY];
}



- (void)setJk_centerX:(CGFloat)jk_centerX {
    
    CGPoint center = self.center;
    center.x = jk_centerX;
    self.center = center;
}

- (CGFloat)jk_centerX {
    
    return self.center.x;
}

- (void)setJk_centerY:(CGFloat)jk_centerY {
    
    CGPoint center = self.center;
    center.y = jk_centerY;
    self.center = center;
}

- (CGFloat)jk_centerY {
    
    return self.center.y;
}
@end
