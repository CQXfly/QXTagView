//
//  ViewController.h
//  QXTagsssView
//
//  Created by 崇庆旭 on 16/3/10.
//  Copyright © 2016年 崇庆旭. All rights reserved.
//
//生成带圆角的图片

#import <UIKit/UIKit.h>

struct JURadius {
    CGFloat topLeftRadius;
    CGFloat topRightRadius;
    CGFloat bottomLeftRadius;
    CGFloat bottomRightRadius;
};
typedef struct JURadius JURadius;

static inline JURadius JURadiusMake(CGFloat topLeftRadius, CGFloat topRightRadius, CGFloat bottomLeftRadius, CGFloat bottomRightRadius) {
    JURadius radius;
    radius.topLeftRadius = topLeftRadius;
    radius.topRightRadius = topRightRadius;
    radius.bottomLeftRadius = bottomLeftRadius;
    radius.bottomRightRadius = bottomRightRadius;
    return radius;
}

@interface UIImage (RoundedCorner)

- (UIImage *)ju_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius;

- (UIImage *)ju_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius withContentMode:(UIViewContentMode)contentMode;

+ (UIImage *)ju_imageWithRoundedCornersAndSize:(CGSize)sizeToFit CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

+ (UIImage *)ju_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius andColor:(UIColor *)color;

+ (UIImage *)ju_imageWithRoundedCornersAndSize:(CGSize)sizeToFit CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage withContentMode:(UIViewContentMode)contentMode;

+ (UIImage *)ju_imageWithRoundedCornersAndSize:(CGSize)sizeToFit JURadius:(JURadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage withContentMode:(UIViewContentMode)contentMode;

@end
