//
//  OSBaseUnitView.m
//  Masonry
//
//  Created by 关东野客 on 1/7/19.
//

#import "OSBaseUnitView.h"
#import "OSBaseStructModel.h"
#import "Masonry.h"

@implementation OSBaseUnitView

- (void)renderUI
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass %@", NSStringFromSelector(_cmd), [self class]];
}


@end
