//
//  GridView.h
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, BorderType) {
//    BorderTypeNone,
//    
//    BorderTypeTop,
//    BorderTypeLeft,
//    BorderTypeRight,
//    BorderTypeBottom,
//    
//    BorderTypeAll,
//};

typedef NS_OPTIONS(NSUInteger, Border) {
    BorderNone = 0,
    
    BorderTop    = 1 << 1,
    BorderRight  = 1 << 2,
    BorderBottom = 1 << 3,
    BorderLeft   = 1 << 4,
    
    BorderLeftTop = ( BorderLeft | BorderTop ),
    BorderRightTop = ( BorderRight | BorderTop ),
    BorderLeftBottom = ( BorderLeft | BorderBottom ),
    BorderRightBottom = ( BorderRight | BorderTop ),
    
    BorderAll = ( BorderLeft | BorderTop | BorderRight | BorderBottom ),
};

@interface GridView : UIView

@property (nonatomic, assign) Border border;

@end
