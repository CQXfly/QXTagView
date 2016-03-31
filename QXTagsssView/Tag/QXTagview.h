//
//  ViewController.h
//  QXTagsssView
//
//  Created by 崇庆旭 on 16/3/10.
//  Copyright © 2016年 崇庆旭. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 这里用不到该枚举 */
typedef NS_ENUM(NSInteger,QXTagviewMarginType) {
    QXTagviewMarginTypeTop,
    QXTagviewMarginTypeBottom,
    QXTagviewMarginTypeLeft,
    QXTagviewMarginTypeRight,
    QXTagviewMarginTypeRow,
    QXTagviewMarginTypeColumn,
};


@class QXTagview,QXTagviewCell;

/**
 *  数据源方法
 */
@protocol QXTagviewDataSource <NSObject>

@required

/**  tell tagview the number of your cells*/
- (NSUInteger) numberOfCellsInTagview:(QXTagview *) tagview;

/**  cell view at index*/
- (QXTagviewCell *) tagview:(QXTagview *) tagview cellAtIndex:(NSUInteger ) index;


@optional

/**  headerview*/
- (UIView *)  headerViewInTagView:(QXTagview *) tagview;

/**  footerview */
- (UIView *) footerViewInTagView:(QXTagview *) tagview;

@end

@protocol QXTagviewDelegate <UIScrollViewDelegate>

@required

/**
 *  the cell's height in index
 */
- (CGFloat) tagview:(QXTagview *) tagview heightForRowInIndex:(NSInteger) index;

/**
 *  the cell's width in index for sort
 *
 *  @return <#return value description#>
 */
- (CGFloat) tagview:(QXTagview *) tagview widthForRowInIndex:(NSInteger) index;

@optional

/**
 *  did select the cell in index
 */
- (void) tagview:(QXTagview *) tagview didSelectAtInIndex:(NSInteger ) index;

/**
 *  the cell's margin with (row,column,top,bottom,right,left)
 */
- (CGFloat) tagview:(QXTagview *) tagview maginForType:(QXTagviewMarginType) type;

@optional


@end

@interface QXTagview : UIScrollView

//set delegate and datasource

@property (nonatomic,weak) id <QXTagviewDataSource> dataSource;


@property (nonatomic,weak) id <QXTagviewDelegate> delegate;

/** reload all frames while you need relayout*/
- (void) reloadData;

- (id) dequeueReusableCellWithIdentifier:(NSString *) identifier;

@end
