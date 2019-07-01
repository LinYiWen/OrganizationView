//
//  OSCustomeUnitView.m
//  OrganizationView_Example
//
//  Created by 关东野客 on 1/7/19.
//  Copyright © 2019 Evan. All rights reserved.
//  

#import "OSCustomeUnitView.h"
#import "OSCustomStructModel.h"
#import "Masonry.h"

@interface OSCustomeUnitView ()

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *imageView;

@end


@implementation OSCustomeUnitView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectZero])
    {
        [self initialUI];
    }
    return self;
}


- (void)initialUI
{
    self.layer.borderColor = [UIColor blueColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5;
    
    _imageView = [UIImageView new];
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self).offset(15);
         make.centerY.equalTo(self);
         make.width.height.mas_equalTo(25);
     }];
    
    _nameLabel = [UILabel new];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(self.imageView.mas_right).offset(15);
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
    }];
    
}


//根据model进行相应赋值

- (void)renderUI
{
    if (![self.model isKindOfClass:[OSCustomStructModel class]])
    {
        return;
    }
    OSCustomStructModel *model = (OSCustomStructModel *)self.model;
    
    _nameLabel.text = model.name;
    _imageView.image = [UIImage imageNamed:model.imageName];
    
}

@end
