//
//  OSBaseUnitView.h
//  Masonry
//
//  Created by 关东野客 on 1/7/19.
//

#import <UIKit/UIKit.h>
@class OSBaseStructModel;

NS_ASSUME_NONNULL_BEGIN

@interface OSBaseUnitView : UIView



@property (nonatomic, strong) OSBaseStructModel *model;


/**
 根据self.model模型渲染视图,子类需重写
 */
- (void)renderUI;

@end

NS_ASSUME_NONNULL_END
