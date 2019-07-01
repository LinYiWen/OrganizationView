//
//  OSViewConfigObj.h
//  Masonry
//
//  Created by 关东野客 on 1/7/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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

NS_ASSUME_NONNULL_END
