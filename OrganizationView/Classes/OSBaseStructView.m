//
//  EEBaseStructView.m
//  TabbarDemo
//
//  Created by Evan on 20/6/19.
//  Copyright © 2019 Evan. All rights reserved.
//

#import "OSBaseStructView.h"
#import "Masonry.h"
#import "OSBaseUnitView.h"

@interface OSBaseStructView ()

@property (nonatomic, strong)UIView *line_h; //水平线
@property (nonatomic, strong)UIView *line_v; //竖直线
@property (nonatomic, strong)UIButton *collapseBtn; //展开或收回按钮    selected = YES 为打开状态

@property (nonatomic, strong)OSBaseUnitView *mainCell; //主cell
@property (nonatomic, strong)UIView *subStructView; //子结构背景
@property (nonatomic, strong)NSMutableArray<OSBaseStructView *> *structViewArray; //子结构数组

@property (nonatomic, assign) CGFloat cellLeftMargin;

@property (nonatomic, strong) OSBaseStructModel *model;
@property (nonatomic, strong) OSViewConfigObj *config;


@end

@implementation OSBaseStructView

- (instancetype)initWithData:(OSBaseStructModel *)data Config:(nullable OSViewConfigObj *)config
{
    if (self = [super initWithFrame:CGRectZero])
    {
        _model = data;
        _config = config ? config : [OSViewConfigObj new];
        _structViewArray = [NSMutableArray array];
        [self initialUI];
    }
    return self;
}

- (void)initialUI
{
    _cellLeftMargin = _config.margin + (_model.level) * (_config.lineMargin + _config.lineLength); //cell的左边距
    
    //--------------cell--------------
    _mainCell = [self.config.cellClass new];
    [self addSubview:_mainCell];
    [_mainCell mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(self).offset(self.cellLeftMargin);
        make.top.equalTo(self).offset(self.config.margin);
        make.width.mas_equalTo(self.config.cellWidth);
        make.height.mas_equalTo(self.config.cellHeight);
    }];
    _mainCell.model = _model;
    [_mainCell renderUI];
    
    //--------------横线--------------
    _line_h = [UIView new];
    _line_h.backgroundColor = self.config.lineColor;
    [self addSubview:_line_h];
    [_line_h mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(self.mainCell.mas_left);
        make.width.mas_equalTo(self.config.lineLength);
        make.centerY.equalTo(self.mainCell);
        make.height.mas_equalTo(0.8);
    }];
    
    //--------------展开按钮--------------
    _collapseBtn = [UIButton new];
    [_collapseBtn addTarget:self action:@selector(collapseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_collapseBtn setImage:self.config.plusImage forState:UIControlStateNormal];
    [_collapseBtn setImage:self.config.dashImage forState:UIControlStateSelected];
    [self addSubview:_collapseBtn];
    [_collapseBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self.line_h);
        make.centerY.equalTo(self.line_h);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    //子cell
    _subStructView = [UIView new];
    _subStructView.hidden = YES;
    [self addSubview:_subStructView];
    [_subStructView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(self);
        make.top.equalTo(self.mainCell.mas_bottom).offset(self.config.margin);
        make.width.mas_equalTo(self.cellLeftMargin + self.config.cellWidth);
    }];
    
    for (OSBaseStructModel *subModel in self.model.subArray)
    {
        UIView *preView = self.structViewArray.lastObject;
        
        OSBaseStructView *subView = [[OSBaseStructView alloc] initWithData:subModel Config:self.config];
        [_subStructView addSubview:subView];
        [subView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.subStructView);
             if (preView)
             {
                 make.top.equalTo(preView.mas_bottom);
             }else
             {
                 make.top.equalTo(self.subStructView);
             }
         }];
        [self.structViewArray addObject:subView];
    }
    
    
    //--------------竖线--------------
    
    _line_v = [UIView new];
    _line_v.backgroundColor = self.config.lineColor;
    [self addSubview:_line_v];
    [_line_v mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.mainCell.mas_bottom);
         make.left.equalTo(self.mainCell).offset(self.config.lineMargin);
         make.width.mas_equalTo(0.8);
     }];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.subStructView);
        make.right.equalTo(self.subStructView);
    }];
    
    //level = 0 按钮默认打开,且隐藏横线和按钮
    if (self.model.level == 0)
    {
        [self collapseBtnClick:_collapseBtn];
        self.line_h.hidden = YES;
        self.collapseBtn.hidden = YES;
        self.subStructView.hidden = NO;
    }
    
    if (self.model.subArray.count == 0)
    {
        self.collapseBtn.hidden = YES;
    }
    
}

- (void)collapseBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _line_v.hidden = !sender.selected;
    _subStructView.hidden = !sender.selected;

    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    if (self.collapseBtn.selected && self.structViewArray.lastObject)
    {
        //subView右边与高度根据实际情况来
        [self.subStructView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.top.equalTo(self.mainCell.mas_bottom).offset(self.config.margin);
            make.bottom.equalTo(self.structViewArray.lastObject).offset(0);
            
            for (UIView *cell in self.structViewArray)
            {
                make.width.greaterThanOrEqualTo(cell).priority(100);
            }
        }];
        
        _line_v.hidden = NO;
        [_line_v mas_updateConstraints:^(MASConstraintMaker *make)
        {
            make.bottom.equalTo(self.subStructView).offset(-self.config.cellHeight*0.5 - self.config.margin);
        }];

    }else
    {
        //subView右边与maincCell相同,高度归0
        [self.subStructView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.top.equalTo(self.mainCell.mas_bottom).offset(self.config.margin);
            make.width.mas_equalTo(self.cellLeftMargin + self.config.cellWidth + self.config.margin);
            make.height.mas_equalTo(0);
        }];
        _line_v.hidden = YES;
        [_line_v mas_updateConstraints:^(MASConstraintMaker *make)
         {
             make.bottom.equalTo(self.subStructView);
         }];
    }

    [super updateConstraints];
}


@end
