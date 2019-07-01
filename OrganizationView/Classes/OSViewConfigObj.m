//
//  OSViewConfigObj.m
//  Masonry
//
//  Created by 关东野客 on 1/7/19.
//

#import "OSViewConfigObj.h"
#import "OSBaseUnitView.h"

@implementation OSViewConfigObj

- (instancetype)init
{
    if (self = [super init])
    {
        _margin = 10;
        _cellWidth = 200;
        _cellHeight = 30;
        _lineLength = 30;
        _lineMargin = 20;
        _lineColor = [UIColor grayColor];
        
        NSBundle *bundle = [NSBundle bundleForClass:[OSViewConfigObj class]];
        NSURL *url = [bundle URLForResource:@"OrganizationView" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        
        NSInteger scale = [[UIScreen mainScreen] scale];
        NSString *imgName = [NSString stringWithFormat:@"%@@%zdx", @"OSPlus",scale];
        NSString *imgName2 = [NSString stringWithFormat:@"%@@%zdx", @"OSDash",scale];
        
        _plusImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:imgName ofType:@"png"]];
        _dashImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:imgName2 ofType:@"png"]];
        
        _cellClass = [OSBaseUnitView class];
    }
    return self;
}

@end
