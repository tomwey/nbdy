//
//  GridView.m
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "GridView.h"
#import "AWHairlineView.h"

@interface GridView ()

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *rightLine;

@end

@implementation GridView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame] ) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIView *)topLine
{
    if ( !_topLine ) {
        _topLine = [[UIView alloc] init];
    }
    return _topLine;
}

@end
