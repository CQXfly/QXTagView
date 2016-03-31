//
//  ViewController.h
//  QXTagsssView
//
//  Created by 崇庆旭 on 16/3/10.
//  Copyright © 2016年 崇庆旭. All rights reserved.
//

#import "QXTagModel.h"

@implementation QXTagModel

+ (instancetype)tagsWithDict:(NSDictionary *)dict {
   
    return [[QXTagModel alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (id)valueForUndefinedKey:(NSString *)key {
    
//    if ([key isEqualToString: @"tagName"]){
//        
//    }
    
    return @"布依族";
}

@end
