//
//  EEBaseStructView.m
//  TabbarDemo
//
//  Created by Evan on 20/6/19.
//  Copyright © 2019 Evan. All rights reserved.
//

#import "OSBaseStructView.h"
#import "Masonry.h"

@interface OSBaseStructView ()

@property (nonatomic, strong)UIView *line_h; //水平线
@property (nonatomic, strong)UIView *line_v; //竖直线
@property (nonatomic, strong)UIButton *collapseBtn; //展开或收回按钮    selected = YES 为打开状态

@property (nonatomic, strong)UIView *mainCell; //主条
@property (nonatomic, strong)UILabel *titleLabel; //主条title
@property (nonatomic, strong)UIView *subStructView; //子结构背景
@property (nonatomic, strong)NSMutableArray<OSBaseStructView *> *structViewArray; //子结构数组

@property (nonatomic, assign) CGFloat cellLeftMargin;

@property (nonatomic, strong) OSBaseStructModel *model;

@end

static const CGFloat margin = 10; //间隙
static const CGFloat cellWidth = 200; //cell宽度
static const CGFloat cellHeight = 40; //cell高度
static const CGFloat lineLength = 30; //横线长度
static const CGFloat lineMargin = 20; //竖线与cell的边距

@implementation OSBaseStructView

- (instancetype)initWithData:(OSBaseStructModel *)data
{
    if (self = [super initWithFrame:CGRectZero])
    {
        _model = data;
        _structViewArray = [NSMutableArray array];
        [self initialUI];
    }
    return self;
}

- (void)initialUI
{
    self.backgroundColor = [UIColor cyanColor];
    
    UIColor *color = [UIColor redColor];
    
    _cellLeftMargin = margin + (_model.level - 1) * (lineMargin + lineLength); //cell的左边距
    
    switch (_model.level) {
        case 2:
            color = [UIColor greenColor];
            break;
        case 3:
            color = [UIColor orangeColor];
            break;
        case 4:
            color = [UIColor purpleColor];
            break;
            
        default:
            break;
    }
    
    //--------------cell--------------
    _mainCell = [UIView new];
    _mainCell.backgroundColor = color;
    [self addSubview:_mainCell];
    [_mainCell mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(self).offset(self.cellLeftMargin);
        make.top.equalTo(self).offset(margin);
        make.width.mas_equalTo(cellWidth);
        make.height.mas_equalTo(cellHeight);
    }];
    
    //--------------文字--------------
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = _model.title;
    [_mainCell addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.edges.equalTo(self.mainCell);
    }];
    
    //--------------横线--------------
    _line_h = [UIView new];
    _line_h.backgroundColor = [UIColor grayColor];
    [self addSubview:_line_h];
    [_line_h mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(self.mainCell.mas_left);
        make.width.mas_equalTo(lineLength);
        make.centerY.equalTo(self.mainCell);
        make.height.mas_equalTo(0.8);
    }];
    
    
    //--------------展开按钮--------------
    _collapseBtn = [UIButton new];
    _collapseBtn.backgroundColor = [UIColor yellowColor];
    [_collapseBtn addTarget:self action:@selector(collapseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_collapseBtn setTitle:@"+" forState:UIControlStateNormal];
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
    _subStructView.backgroundColor = [UIColor purpleColor];
    _subStructView.hidden = YES;
    [self addSubview:_subStructView];
    [_subStructView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(self);
        make.top.equalTo(self.mainCell.mas_bottom).offset(margin);
        make.width.mas_equalTo(self.cellLeftMargin + cellWidth);
    }];
    
    for (OSBaseStructModel *subModel in self.model.subArray)
    {
        UIView *preView = self.structViewArray.lastObject;
        
        OSBaseStructView *subView = [[OSBaseStructView alloc] initWithData:subModel];
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
    _line_v.backgroundColor = [UIColor grayColor];
    [self addSubview:_line_v];
    [_line_v mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.mainCell.mas_bottom);
         make.left.equalTo(self.mainCell).offset(lineMargin);
         make.width.mas_equalTo(0.8);
     }];
    
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.subStructView);
        make.right.equalTo(self.subStructView);
    }];
    
    //level = 1 按钮默认打开,且隐藏横线和按钮
    if (self.model.level == 1)
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
            make.top.equalTo(self.mainCell.mas_bottom).offset(margin);
            make.bottom.equalTo(self.structViewArray.lastObject).offset(0);
            
            for (UIView *cell in self.structViewArray)
            {
                make.width.greaterThanOrEqualTo(cell).priority(100);
            }
        }];
        
        _line_v.hidden = NO;
        [_line_v mas_updateConstraints:^(MASConstraintMaker *make)
        {
            make.bottom.equalTo(self.subStructView).offset(-cellHeight*0.5 - margin);
        }];

    }else
    {
        //subView右边与maincCell相同,高度归0
        [self.subStructView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.top.equalTo(self.mainCell.mas_bottom).offset(margin);
            make.width.mas_equalTo(self.cellLeftMargin + cellWidth + margin);
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
