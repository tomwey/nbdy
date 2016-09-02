//
//  ModuleGridView.h
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BorderType) {
    BorderTypeTop,
    BorderTypeBottom,
    BorderTypeLeft,
    BorderTypeRight
};

@class Module;
@interface ModuleGridView : UIView

@property (nonatomic, retain) Module *module;

//- (void)showBorder:(BorderType)borderType;
//
//- (void)hideBorder:(BorderType)borderType;

@end
