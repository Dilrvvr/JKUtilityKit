//
//  UIView+JKUtilityFrame.h
//  JKUtilityKit
//
//  Created by albert on 2020/8/7.
//

#import <UIKit/UIKit.h>

@interface UIView (JKUtilityFrame)

/** X */
@property (nonatomic, assign) CGFloat jk_x;

/** X */
@property (nonatomic, assign) CGFloat jk_left;


/** Y */
@property (nonatomic, assign) CGFloat jk_y;

/** Y */
@property (nonatomic, assign) CGFloat jk_top;


/** origin */
@property (nonatomic, assign) CGPoint jk_origin;


/** 宽度 */
@property (nonatomic, assign) CGFloat jk_width;

/** 高度 */
@property (nonatomic, assign) CGFloat jk_height;

/** 尺寸 */
@property (nonatomic, assign) CGSize jk_size;


/** maxX */
@property (nonatomic, assign) CGFloat jk_maxX;

/** maxX */
@property (nonatomic, assign) CGFloat jk_right;


/** maxY */
@property (nonatomic, assign) CGFloat jk_maxY;

/** maxY */
@property (nonatomic, assign) CGFloat jk_bottom;



/** centerX */
@property (nonatomic, assign) CGFloat jk_centerX;

/** centerY */
@property (nonatomic, assign) CGFloat jk_centerY;
@end
