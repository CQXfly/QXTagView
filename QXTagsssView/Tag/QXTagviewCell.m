//
//  ViewController.h
//  QXTagsssView
//
//  Created by 崇庆旭 on 16/3/31.
//  Copyright © 2016年 崇庆旭. All rights reserved.
//

#import "QXTagviewCell.h"

#import "UIView+RoundedCorner.h"
@interface QXTagviewCell  ()



@end

@implementation QXTagviewCell

- (instancetype) initWithIdentifier:(NSString *) identifier
{
    QXTagviewCell *cell = [[QXTagviewCell alloc] init];
    if (self = [super init]) {
        cell.identifier = identifier;
        [self setUpSubviews];
    }
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews
{

    UILabel *textLabel = [[UILabel alloc] init];
    self.textLabel = textLabel;
    [self addSubview:textLabel];
    textLabel.font = [UIFont systemFontOfSize:15];
    
    textLabel.textAlignment = NSTextAlignmentCenter;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
 
    
}


@end
