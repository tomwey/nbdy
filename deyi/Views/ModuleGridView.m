//
//  ModuleGridView.m
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "ModuleGridView.h"

@interface ModuleGridView ()

@end
@implementation ModuleGridView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame] ) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.clipsToBounds = YES;
    }
    return self;
}

@end
