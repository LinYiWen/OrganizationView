//
//  OSViewController.m
//  OrganizationView
//
//  Created by Evan on 06/28/2019.
//  Copyright (c) 2019 Evan. All rights reserved.
//

#import "OSViewController.h"
#import "OSBaseStructView.h"
#import "OSCustomStructModel.h"
#import "OSCustomeUnitView.h"
#import "Masonry.h"

@interface OSViewController ()

@property (nonatomic, strong)OSCustomStructModel *dataSource; //数据源

@end

@implementation OSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.equalTo(self.view);
     }];
    
    //配置 organization struct view
    OSViewConfigObj *config = [OSViewConfigObj new];
    config.cellClass = [OSCustomeUnitView class]; //自定义view类
    config.cellHeight = 44;
    config.cellWidth = 200;
    
    //初始化
    OSBaseStructView *structView = [[OSBaseStructView alloc] initWithData:self.dataSource Config:config];
    
    [scrollView addSubview:structView];
    [structView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.equalTo(scrollView).insets(UIEdgeInsetsMake(100, 0, 30, 0));
     }];
    
    
}


- (OSCustomStructModel *)dataSource
{
    if (!_dataSource)
    {
        OSCustomStructModel *model = [OSCustomStructModel new];
        model.name = @"0级标题";
        model.level = 0;
        model.imageName = @"written";
        
        NSMutableArray *arr4 = [NSMutableArray arrayWithCapacity:3];
        for (NSInteger i = 0; i < 4; i++)
        {
            OSCustomStructModel *model = [OSCustomStructModel new];
            model.name = [NSString stringWithFormat:@"3级标题--%ld", i];
            model.level = 3;
            model.imageName = @"icon";
            [arr4 addObject:model];
        }
        
        NSMutableArray *arr3 = [NSMutableArray arrayWithCapacity:3];
        for (NSInteger i = 0; i < 6; i++)
        {
            OSCustomStructModel *model = [OSCustomStructModel new];
            model.name = [NSString stringWithFormat:@"2级标题--%ld", i];
            model.level = 2;
            model.imageName = @"written";
            if (i == 1) {
                model.subArray = arr4.copy;
            }
            [arr3 addObject:model];
        }
        
        NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:5];
        for (NSInteger i = 0; i < 10; i++)
        {
            OSCustomStructModel *model = [OSCustomStructModel new];
            model.name = [NSString stringWithFormat:@"1级标题--%ld", i];
            model.level = 1;
            model.imageName = @"icon";
            if (i == 2)
            {
                model.subArray = arr3.copy;
            }
            
            [arr2 addObject:model];
        }
        
        model.subArray = arr2.copy;
        
        _dataSource = model;
    }
    return _dataSource;
}

@end
