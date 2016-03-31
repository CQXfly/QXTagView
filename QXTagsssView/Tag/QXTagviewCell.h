//
//  ViewController.h
//  QXTagsssView
//
//  Created by 崇庆旭 on 16/3/10.
//  Copyright © 2016年 崇庆旭. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QXTagviewCell : UIView
/**标签 */
@property (nonatomic,strong) UILabel *textLabel;
/**  重用标识符*/
@property (nonatomic, copy) NSString *identifier;

- (instancetype) initWithIdentifier:(NSString *) identifier;

@end
