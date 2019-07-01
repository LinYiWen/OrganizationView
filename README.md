# OrganizationView

[![CI Status](https://img.shields.io/travis/Evan/OrganizationView.svg?style=flat)](https://travis-ci.org/Evan/OrganizationView)
[![Version](https://img.shields.io/cocoapods/v/OrganizationView.svg?style=flat)](https://cocoapods.org/pods/OrganizationView)
[![License](https://img.shields.io/cocoapods/l/OrganizationView.svg?style=flat)](https://cocoapods.org/pods/OrganizationView)
[![Platform](https://img.shields.io/cocoapods/p/OrganizationView.svg?style=flat)](https://cocoapods.org/pods/OrganizationView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

OrganizationView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OrganizationView'
```

## Introduction

根据数据源和自定义view，自动生成团队组织架构图View，可根据数据量自动约束高度和宽度

![](https://github.com/LinYiWen/OrganizationView/blob/master/preview/screenshot1.jpeg)
![](https://github.com/LinYiWen/OrganizationView/blob/master/preview/screenshot2.jpeg)

## Usage

1.创建一个自定义模型类，必须继承自OSBaseStructModel，可在类中添加自定义属性

```oc
@interface OSCustomStructModel : OSBaseStructModel

//自定义属性
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageName;

@end
```

2.创建一个自定义View，必须继承自OSBaseUnitView，自定义结构图cell的UI，必需重写 - (void)renderUI 方法

```oc
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
```
3.初始化配置对象

```oc
OSViewConfigObj *config = [OSViewConfigObj new];
config.cellClass = [OSCustomeUnitView class]; //自定义view类
config.cellHeight = 44;
config.cellWidth = 200;
```

```oc
@interface OSViewConfigObj : NSObject

@property (nonatomic, assign) CGFloat margin; //间隙 default: 10
@property (nonatomic, assign) CGFloat cellWidth; //cell宽度 default: 200
@property (nonatomic, assign) CGFloat cellHeight; //cell高度 default: 40
@property (nonatomic, assign) CGFloat lineLength; //横线长度 default: 30
@property (nonatomic, assign) CGFloat lineMargin; //竖线与cell的边距 default: 20

@property (nonatomic, strong) UIColor *lineColor; //线条颜色 default: grayColor

@property (nonatomic, strong) UIImage *plusImage; //展开按钮图片 default: +
@property (nonatomic, strong) UIImage *dashImage; //关闭按钮图片 default: -

@property (nonatomic, strong) Class cellClass; //cell类 default: OSBaseUnitView, 自定义需继承自OSBaseUnitView且重写setModel方法,暂不支持xib

@end
```

4.根据自定义模型类生成 数据源 level从0开始

```oc

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

```

5.生成组织结构图，并添加在scrollView中

```oc

UIScrollView *scrollView = [UIScrollView new];
[self.view addSubview:scrollView];
[scrollView mas_makeConstraints:^(MASConstraintMaker *make)
{
    make.edges.equalTo(self.view);
}];
     
OSBaseStructView *structView = [[OSBaseStructView alloc] initWithData:self.dataSource Config:config];
    
[scrollView addSubview:structView];
[structView mas_makeConstraints:^(MASConstraintMaker *make)
{
    make.edges.equalTo(scrollView).insets(UIEdgeInsetsMake(100, 0, 30, 0));
}];

```


## Author

Evan, 381759536@qq.com

## License

OrganizationView is available under the MIT license. See the LICENSE file for more info.


