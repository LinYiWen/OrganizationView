//
//  EEBaseStructView.h
//  TabbarDemo
//
//  Created by Evan on 20/6/19.
//  Copyright © 2019 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSBaseStructModel.h"
#import "OSViewConfigObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface OSBaseStructView : UIView


/**
 初始化StructView

 @param data 数据源
 @param config 配置信息,可为nil
 @return StructView
 */
- (instancetype)initWithData:(OSBaseStructModel *)data Config:(nullable OSViewConfigObj *)config;

@end

NS_ASSUME_NONNULL_END
