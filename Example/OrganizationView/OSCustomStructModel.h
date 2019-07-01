//
//  OSCustomStructModel.h
//  OrganizationView_Example
//
//  Created by 关东野客 on 1/7/19.
//  Copyright © 2019 Evan. All rights reserved.
//  自定义model

#import "OSBaseStructModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OSCustomStructModel : OSBaseStructModel

//自定义属性
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageName;

@end

NS_ASSUME_NONNULL_END
