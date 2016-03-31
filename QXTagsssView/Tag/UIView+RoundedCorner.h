//
//  ViewController.h
//  QXTagsssView
//
//  Created by 崇庆旭 on 16/3/10.
//  Copyright © 2016年 崇庆旭. All rights reserved.
//
//使用这个类就可以了

#import <UIKit/UIKit.h>
#import "UIImage+RoundedCorner.h"

@interface UIView (RoundedCorner)

/**给view设置一个圆角边框 默认圆角弧度一致*/
- (void)ju_setCornerRadius:(CGFloat)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**给view设置一个圆角边框,四个圆角弧度可以不同*/
- (void)ju_setJURadius:(JURadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;


/**设置所有属性配置出一个圆角背景图*/
- (void)ju_setCornerRadius:(CGFloat)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode;

/**设置所有属性配置出一个圆角背景图,四个圆角弧度可以不同*/
- (void)ju_setJURadius:(JURadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode;

/**设置所有属性配置出一个圆角背景图，并多传递了一个size参数，如果juRoundedCorner没有拿到view的size，可以调用这个方法*/
- (void)ju_setJURadius:(JURadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode size:(CGSize)size;

@end
