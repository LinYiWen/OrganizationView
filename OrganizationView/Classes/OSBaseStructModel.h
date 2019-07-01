//
//  EEBaseStructModel.h
//  TabbarDemo
//
//  Created by Evan on 20/6/19.
//  Copyright © 2019 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSBaseStructModel : NSObject

@property (nonatomic, assign) NSInteger level; //等级从0开始,必填

@property (nonatomic, strong) NSArray<OSBaseStructModel *> *subArray;

@end

NS_ASSUME_NONNULL_END
