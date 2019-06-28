//
//  EEBaseStructView.h
//  TabbarDemo
//
//  Created by Evan on 20/6/19.
//  Copyright © 2019 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSBaseStructModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OSBaseStructView : UIView

- (instancetype)initWithData:(OSBaseStructModel *)data;

@end

NS_ASSUME_NONNULL_END
