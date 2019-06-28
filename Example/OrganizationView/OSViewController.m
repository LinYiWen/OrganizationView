//
//  OSViewController.m
//  OrganizationView
//
//  Created by Evan on 06/28/2019.
//  Copyright (c) 2019 Evan. All rights reserved.
//

#import "OSViewController.h"
#import "OSBaseStructView.h"
#import "Masonry.h"

@interface OSViewController ()



@end

@implementation OSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    OSBaseStructModel *model = [OSBaseStructModel new];
    model.title = @"一级标题";
    model.level = 1;
    
    NSMutableArray *arr4 = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 0; i < 4; i++)
    {
        OSBaseStructModel *model = [OSBaseStructModel new];
        model.title = [NSString stringWithFormat:@"四级标题--%ld", i];
        model.level = 4;
        [arr4 addObject:model];
    }
    
    
    NSMutableArray *arr3 = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 0; i < 6; i++)
    {
        OSBaseStructModel *model = [OSBaseStructModel new];
        model.title = [NSString stringWithFormat:@"三级标题--%ld", i];
        model.level = 3;
        if (i == 1) {
            model.subArray = arr4.copy;
        }
        [arr3 addObject:model];
    }
    
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:5];
    for (NSInteger i = 0; i < 10; i++)
    {
        OSBaseStructModel *model = [OSBaseStructModel new];
        model.title = [NSString stringWithFormat:@"二级标题--%ld", i];
        model.level = 2;
        if (i == 2)
        {
            model.subArray = arr3.copy;
        }
        
        [arr2 addObject:model];
    }
    
    model.subArray = arr2.copy;
    
    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.equalTo(self.view);
     }];
    
    OSBaseStructView *structView = [[OSBaseStructView alloc] initWithData:model];
    
    [scrollView addSubview:structView];
    [structView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.equalTo(scrollView).insets(UIEdgeInsetsMake(100, 0, 30, 0));
         //         make.width.mas_equalTo(SCREEN_WIDTH);
         
     }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
