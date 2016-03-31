//
//  ViewController.h
//  QXTagsssView
//
//  Created by 崇庆旭 on 16/3/10.
//  Copyright © 2016年 崇庆旭. All rights reserved.
//

#import "UIView+RoundedCorner.h"
#import <objc/runtime.h>

extern float pixel(float num) {
    float unit = 1.0 / [UIScreen mainScreen].scale;
    double remain = fmod(num, unit);
    return num - remain + (remain >= unit / 2.0? unit: 0);
}

@implementation UIView (RoundedCorner)

- (void)ju_setCornerRadius:(CGFloat)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    [self ju_setCornerRadius:radius withBorderColor:borderColor borderWidth:borderWidth backgroundColor:nil backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
}

- (void)ju_setJURadius:(JURadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    [self ju_setJURadius:radius withBorderColor:borderColor borderWidth:borderWidth backgroundColor:nil backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
}

- (void)ju_setCornerRadius:(CGFloat)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode {
    [self ju_setJURadius:JURadiusMake(radius, radius, radius, radius) withBorderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor backgroundImage:backgroundImage contentMode:contentMode];
}

- (void)ju_setJURadius:(JURadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode {
    NSValue *radiusValue = [NSValue valueWithBytes:&radius objCType:@encode(JURadius)];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[@"radius"] = radiusValue;
    
    if (borderColor)
        dic[@"borderColor"] = borderColor;
    else
        dic[@"borderColor"] = NSNull.null;
    
    dic[@"borderWidth"] = [NSNumber numberWithFloat:borderWidth];
    
    if (backgroundColor)
        dic[@"backgroundColor"] = backgroundColor;
    else
        dic[@"backgroundColor"] = NSNull.null;
    
    if (backgroundImage)
        dic[@"backgroundImage"] = backgroundImage;
    else
        dic[@"backgroundImage"] = NSNull.null;
    
    dic[@"contentMode"] = [NSNumber numberWithFloat:contentMode];
    
    [self setNeedsLayout];
    [self performSelector:@selector(setRadius:) withObject:dic afterDelay:0 inModes:@[NSRunLoopCommonModes]];
}

- (void)setRadius:(NSMutableDictionary *)dic {
    JURadius radius;
    [dic[@"radius"] getValue:&radius];
    UIColor *borderColor;
    UIColor *backgroundColor;
    UIImage *backgroundImage;
    
    if (dic[@"borderColor"] == NSNull.null)
        borderColor = nil;
    else
        borderColor = dic[@"borderColor"];
    
    if (dic[@"backgroundColor"] == NSNull.null)
        backgroundColor = nil;
    else
        backgroundColor = dic[@"backgroundColor"];
    
    if (dic[@"backgroundImage"] == NSNull.null)
        backgroundImage = nil;
    else
        backgroundImage = dic[@"backgroundImage"];
    
    [self ju_setJURadius:radius withBorderColor:borderColor borderWidth:[dic[@"borderWidth"] floatValue] backgroundColor:backgroundColor backgroundImage:backgroundImage contentMode:[dic[@"contentMode"] integerValue] size:self.bounds.size];
}

- (void)ju_setJURadius:(JURadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode size:(CGSize)size {
    if (size.width == 0 || size.height == 0) {
        NSLog(@" juRoundedCorner 可能出了点状况，没有在布局之后拿到 view 的 size ，可以调用方法，- ju_setJURadius: withBorderColor: borderWidth: backgroundColor: backgroundImage: contentMode: size:");
        return;
    }
    size = CGSizeMake(pixel(size.width), pixel(size.height));
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage ju_imageWithRoundedCornersAndSize:size JURadius:radius borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor backgroundImage:backgroundImage withContentMode:contentMode];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.frame = CGRectMake(pixel(self.frame.origin.x), pixel(self.frame.origin.y), size.width, size.height);
            if ([self isKindOfClass:[UIImageView class]]) {
                ((UIImageView *)self).image = image;
            } else if ([self isKindOfClass:[UIButton class]] && backgroundImage) {
                [((UIButton *)self) setBackgroundImage:image forState:UIControlStateNormal];
            } else if ([self isKindOfClass:[UILabel class]]) {
                self.layer.backgroundColor = [UIColor colorWithPatternImage:image].CGColor;
                
            } else {
                self.layer.contents = (__bridge id _Nullable)(image.CGImage);
            }
        });
    });
}



@end
