//
//  ViewController.h
//  QXTagsssView
//
//  Created by 崇庆旭 on 16/3/31.
//  Copyright © 2016年 崇庆旭. All rights reserved.
//

#import "ViewController.h"
#import "QXTagview.h"
#import "QXTagviewCell.h"
#import "QXTagModel.h"
#import "UIView+RoundedCorner.h"


@interface ViewController () <QXTagviewDataSource,QXTagviewDelegate>

@property (nonatomic,strong) QXTagview *tagview;

@property (nonatomic,strong) NSMutableArray * tags;

@end

@implementation ViewController

- (NSMutableArray *)tags {
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    QXTagview *tagView = [[QXTagview alloc] init];
    tagView.frame = self.view.bounds;
    tagView.delegate = self;
    tagView.dataSource = self;
    self.tagview = tagView;
    [self.view addSubview:tagView];
    
    
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"tags" ofType:@"json"];
    NSArray *a = [NSArray arrayWithContentsOfFile:file];
    
    
    for (NSDictionary * dic  in a ) {
        
        
        QXTagModel *model = [QXTagModel tagsWithDict:dic];
        
        
        if (![model isKindOfClass:NSClassFromString(@"QXTagModel")]) {
            
            return;
        }
        
        [self.tags addObject:model];
    }
    
    
    
    
    [self.tagview reloadData];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark -QXWaterflowerviewDataSource

- (NSUInteger) numberOfCellsInTagview:(QXTagview *)tagview
{
    
    return self.tags.count;
}

- (QXTagviewCell *) tagview:(QXTagview *)tagview cellAtIndex:(NSUInteger)index
{
    static NSString *ID = @"reusable";
    
    
    QXTagviewCell *cell = [tagview dequeueReusableCellWithIdentifier:ID];
    if ( !cell) {
        cell = [[QXTagviewCell alloc] initWithIdentifier:ID];
    }
    
    //    cell.backgroundColor = [UIColor blueColor];
    
    QXTagModel *model = self.tags[index];
    
    
    
    cell.textLabel.text = model.tagname;
    
    [cell.textLabel ju_setCornerRadius:10 withBorderColor:[UIColor blackColor] borderWidth:1.0f];
    
    //    NSLog(@"cell label %@",NSStringFromCGRect(cell.textLabel.frame));
    
    
    return cell;
}


#pragma mark - QXWaterflowerviewDelegate

- (CGFloat) tagview:(QXTagview *)tagview heightForRowInIndex:(NSInteger)index{
    
    
    return 20;
}

- (CGFloat)tagview:(QXTagview *)tagview widthForRowInIndex:(NSInteger)index {
    
    NSDictionary *attri = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    
    QXTagModel *model = self.tags[index];
    
    CGSize size = [model.tagname boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil].size;
    
    
    //    NSLog(@" w %.2lf , %zd",size.width,index);
    
    return size.width;
}



- (UIView *) headerViewInTagView:(QXTagview *)tagview
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    view.bounds = CGRectMake(0, 0, 365, 100);
    
    return view;
}

- (UIView *)footerViewInTagView:(QXTagview *)tagview {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    view.bounds = CGRectMake(0, 0, 365, 100);
    
    return view;
}

-(void) tagview:(QXTagview *)tagview didSelectAtInIndex:(NSInteger)index
{
    NSLog(@"%@ %zd",[self.tags[index] tagname] , index);
}

@end
