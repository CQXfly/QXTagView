//
//  ViewController.h
//  QXTagsssView
//
//  Created by 崇庆旭 on 16/3/10.
//  Copyright © 2016年 崇庆旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QXTagModel : NSObject

@property (nonatomic,copy) NSString *lock;

@property (nonatomic,copy) NSString *tag_fatherid;

@property (nonatomic,copy) NSString *tagname;

+ (instancetype)tagsWithDict:(NSDictionary *)dict;

@end
