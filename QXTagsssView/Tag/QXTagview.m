//
//  ViewController.h
//  QXTagsssView
//
//  Created by 崇庆旭 on 16/3/10.
//  Copyright © 2016年 崇庆旭. All rights reserved.
//


#import "QXTagview.h"
#import "QXTagviewCell.h"


/** 左右间距最小值*/
static CGFloat const kQXTagMinLeftMargin = 15;
/** 行上下间距 */
static CGFloat const kQXTagTopRowMargin = 20;
/** 每个cell之间 左右的间距*/
static CGFloat const kQXTagMiddleMargin = 10;
/** 每个cell额外加的宽度*/
static CGFloat const kQXTagCellExteraWidth = 10;
/** 默认的cell高度*/
static CGFloat const kQXTagviewDefaultCellHeight = 15;
/** 默认的cell宽度*/
static CGFloat const kQXTagviewDefaultCellWidth = 100;

static CGFloat const kQXFooterViewMargin = 20;


@interface QXTagview ()

/**  存放所有的frame*/
@property (nonatomic,strong) NSMutableArray *cellFrames;
/**存放正在展示的cell*/
@property (nonatomic,strong) NSMutableDictionary *displayingCells;

/** 自定义的缓存池*/
@property (nonatomic,strong) NSMutableSet *reusableCells;

@property (nonatomic,assign) CGFloat width_screen;

@property (nonatomic,assign) CGFloat height_screen;

@end

@implementation QXTagview


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.width_screen = [UIScreen mainScreen].bounds.size.width;
        self.height_screen = [UIScreen mainScreen].bounds.size.height;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

#pragma mark - publicAPI
/**
 *  刷新 ,从数据源中得到数据 计算每一个cell的frame
 */
- (void) reloadData
{
    
    //数据源方法需要返还的数据
    self.width_screen = [UIScreen mainScreen].bounds.size.width;
    self.height_screen = [UIScreen mainScreen].bounds.size.height;
    UIView *headerview = [self headerViewInTagview:self];
    UIView *footerView = [self footerViewInTagview:self];
    
    //cell的总数
    NSUInteger numberOfCells = [self.dataSource numberOfCellsInTagview:self];
    

    [self caculateWithNumberOfCells:numberOfCells WithHeaderView:headerview WithFooterView:footerView];
    
    if(headerview) {
        [self addSubview:headerview];
    }
    if(footerView) {
        [self addSubview:footerView];
    }
    
}


- (void) caculateWithNumberOfCells:(NSUInteger)count WithHeaderView:(UIView *)headerView WithFooterView:(UIView *)footerView {
    
    NSInteger rows = 0; //行数
    
    NSMutableArray *tmpArr = [NSMutableArray array];  // 存放每一行的cell的宽度

    CGFloat maxX = 0 ;// 每一行的最大X值 换行置0
    
    CGFloat cellH = [self heightAtIndex:0]; //(高度固定随便传个数就好了)
    
    CGFloat effectiveW = self.width_screen - 2 * kQXTagMinLeftMargin ;// 有效宽度  屏幕宽度减去左右最小间距
    
    NSInteger beginR = 0; //每一行开始的位置
    NSInteger endR = 0; //每一行结束的位置
    
    /********************/
    CGFloat headerFrameH = headerView ? headerView.frame.size.height : 0 ;
    CGFloat footerFrameH = footerView ? footerView.frame.size.height : 0 ;
    
    //计算每个cell的尺寸
    for (int i = 0; i < count ; i ++) {
        
        CGFloat textW = [self widthAtIndex:i];
        
        //最小值 + cellWidth + 间距
        
        if (i ==  0) {
            maxX = (textW + kQXTagCellExteraWidth) + maxX;
        } else {
            maxX = (textW + kQXTagCellExteraWidth)+ kQXTagMiddleMargin + maxX;
        }
    
        
        [tmpArr addObject:@(textW + kQXTagCellExteraWidth)];
        //如果比他大就换行
        if (maxX > effectiveW ) {
            //只有发现需要换行的时候才开始计算每一个frame
            endR = i - 1;
            //实际的宽度
            CGFloat realW = maxX - (textW + kQXTagCellExteraWidth + kQXTagMiddleMargin);
            //计算边距
            //TODO
            CGFloat leftMargin = (effectiveW - realW) / 2.0;
            
            for (NSInteger j = beginR ; j <= endR ; j ++) {
                
                CGFloat cellW = [tmpArr[j] floatValue];
                
                
                
                CGFloat cellX = 0;
                if (j == beginR) {
                    cellX = leftMargin + kQXTagMinLeftMargin ;
                    

                } else {
                    CGRect frame = [self.cellFrames[j - 1] CGRectValue];
                    
                    cellX = kQXTagMiddleMargin + CGRectGetMaxX(frame);
                    
                }
                
                 //记得加上上一个cell的最大X 如果上一个是在这里的话
                
                CGFloat cellY = kQXTagTopRowMargin + (cellH + kQXTagTopRowMargin) * rows + headerFrameH;
                
                CGRect frame = CGRectMake(cellX, cellY, cellW, cellH);
                
                [self.cellFrames addObject:[NSValue valueWithCGRect:frame]];
                
            }
            
            
            beginR = i ;
            rows ++;
            maxX = textW + kQXTagCellExteraWidth;
            
            
        }
        
        
    }
    
    //调整footerview 与 headerview的位置 小于宽度居中 大于宽度压缩
    CGRect headerF = headerView.frame;
    headerF.origin = (CGPoint){0,0};
    if (headerF.size.width > self.width_screen ) {
        CGFloat h = self.width_screen * headerF.size.height / headerF.size.width ;
        headerF.size = (CGSize){self.width_screen,h};
    } else {
        CGFloat margin = (self.width_screen - headerF.size.width) / 2;
        headerF.origin = (CGPoint){margin,0};
    }
    
    
    headerView.frame = headerF;
    
    
    
    CGFloat contenH = rows *(kQXTagTopRowMargin + cellH) + headerFrameH ;
    
    //调整footerview 与 headerview的位置
    CGRect footerF = footerView.frame;
    footerF.origin = (CGPoint){0,contenH + kQXFooterViewMargin};
    if (footerF.size.width > self.width_screen ) {
        CGFloat h = self.width_screen * footerF.size.height / footerF.size.width ;
        footerF.size = (CGSize){self.width_screen,h};
    } else {
        CGFloat margin = (self.width_screen - footerF.size.width) / 2;
        footerF.origin = (CGPoint){margin,contenH + kQXFooterViewMargin};
    }
    footerView.frame = footerF;
    
    contenH += footerFrameH + kQXFooterViewMargin;
    
    self.contentSize = CGSizeMake(0, contenH);
    
}


- (CGRect) cellFramOfIndex:(NSInteger) index {
 
    return CGRectZero;
}

#pragma mark - 重用

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger numberofCells = self.cellFrames.count;
    
    for (int i = 0; i < numberofCells; i ++) {
         CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        //take out cell from dictionary
        // the cell for the index. ps: yuor cell will be nil for the first time;
        QXTagviewCell *cell = self.displayingCells[@(i)];
        //用来判断i位置所对应的frame是否在当前的屏幕上  在的话显示 不在的话隐藏
        if ([self isInScreen:cellFrame])
        {
            if (!cell) { //cell不存在
                //将这个位置的cell 添加到屏幕上
                cell = [self.dataSource tagview:self  cellAtIndex:i ];
                cell.frame = cellFrame;
                [self addSubview:cell];
                
                //存放到字典中
                self.displayingCells[@(i)] = cell;
                
            }
        } else{ //不再屏幕上
            
            if (cell) {
                //将这个cell从字典中移除 保证字典中的对象都是当前屏幕上的
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                
                //将不在屏幕上的cell放入缓存池中
                [self.reusableCells addObject:cell];
                
            }
        }
    }

}

/**
 *
 *  利用重用标识符从缓存池中找到cell
 */
- (id) dequeueReusableCellWithIdentifier:(NSString *) identifier
{
    
    // 用bloclk 修饰过才能在block中赋值成功
    __block QXTagviewCell *reusableCell = nil;
    
   
    [self.reusableCells enumerateObjectsUsingBlock:^(QXTagviewCell *cell, BOOL *stop) {

        if ([cell.identifier isEqualToString:identifier ] ) {
            reusableCell = cell;
            *stop = YES;
        }
    }];
    
    if (reusableCell) { // 找到了这个可以重用的cell 就从缓存池中删除 避免数据累积
        [self.reusableCells removeObject:reusableCell];
    }
    
    return reusableCell;
}

#pragma mark - priviateAPI


/**
 *  判断一个cell的frame 是否是在屏幕上
 *
 *  @param frame cell的frame
 *
 *  @return Bool
 */
- (BOOL)isInScreen:(CGRect)frame
{
    return (CGRectGetMaxY(frame) > self.contentOffset.y) &&
    (CGRectGetMinY(frame) < self.contentOffset.y + self.frame.size.height);
}


/**
 *  cell height
 */
- (CGFloat) heightAtIndex:(NSUInteger) index
{
    if ([self.delegate respondsToSelector:@selector(tagview:heightForRowInIndex:)]) {
        return [self.delegate tagview:self heightForRowInIndex:index];
    } else
    {
        return kQXTagviewDefaultCellHeight;
    }
}

/** 获得每一个cell的宽度 */
- (CGFloat) widthAtIndex:(NSUInteger) index
{
    if ([self.delegate respondsToSelector:@selector(tagview:widthForRowInIndex:)]) {
        return [self.delegate tagview:self widthForRowInIndex:index];
    } else {
        
        return  kQXTagviewDefaultCellWidth;
    }

}

/**  headerview*/

- (UIView *) headerViewInTagview:(QXTagview *) waterview
{
    if ([self.dataSource respondsToSelector:@selector(headerViewInTagView:)]) {
        return  [self.dataSource headerViewInTagView:self];
    } return nil;
}

/**  是否有footerView*/
- (UIView *) footerViewInTagview:(QXTagview *) waterview
{
    if ([self.dataSource respondsToSelector:@selector(footerViewInTagView:)]) {
        return  [self.dataSource footerViewInTagView:self];
    } return nil;
}

#pragma mark - 事件处理
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.delegate respondsToSelector:@selector(tagview:didSelectAtInIndex:)]) return;
    
    UITouch *touch = [touches anyObject];
    //    CGPoint point = [touch locationInView:touch.view];
    CGPoint point = [touch locationInView:self];
    
    __block NSNumber *selectIndex = nil;
    [self.displayingCells enumerateKeysAndObjectsUsingBlock:^(id key, QXTagviewCell *cell, BOOL *stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            selectIndex = key;
            *stop = YES;
        }
    }];
    
    if (selectIndex) {
        [self.delegate tagview :self didSelectAtInIndex:selectIndex.unsignedIntegerValue];
    }
}

#pragma mark - getter

- (NSMutableArray *)cellFrames
{
    if (_cellFrames == nil) {
        self.cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

- (NSMutableDictionary *)displayingCells
{
    if (_displayingCells == nil) {
        self.displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}

- (NSMutableSet *)reusableCells
{
    if (_reusableCells == nil) {
        self.reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}


@end
