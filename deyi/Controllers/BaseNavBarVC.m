//
//  BaseNavBarVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "BaseNavBarVC.h"
#import "Defines.h"

#define kNavBarLeftItemTag 1011
#define kNavBarRightItemTag 1012

@interface BaseNavBarVC ()

@property (nonatomic, copy, nullable) void (^leftItemCallback)(void);
@property (nonatomic, copy, nullable) void (^rightItemCallback)(void);

@end

@implementation BaseNavBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UIView *)addLeftBarItemWithImage:(NSString *)imageName  callback:(void (^)(void))callback
{
    self.leftItemCallback = callback;
    
    imageName = [imageName trim];
    if ( [imageName length] == 0 ) {
        self.navigationItem.leftBarButtonItem = nil;
        return nil;
    } else {
        UIButton *btn = AWCreateImageButton(imageName, self, @selector(btnClicked:));
        btn.tag = kNavBarLeftItemTag;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        return btn;
    }
}

- (UIView *)addRightBarItemWithImage:(NSString *)imageName callback:(void (^)(void))callback
{
    self.rightItemCallback = callback;
    
    imageName = [imageName trim];
    if ( [imageName length] == 0 ) {
        self.navigationItem.rightBarButtonItem = nil;
        return nil;
    } else {
        UIButton *btn = AWCreateImageButton(imageName, self, @selector(btnClicked:));
        btn.tag = kNavBarRightItemTag;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        return btn;
    }
}

- (UIView *)addLeftBarItemWithTitle:(NSString *)title  size:(CGSize)size callback:(void (^)(void))callback
{
    self.leftItemCallback = callback;
    
    title = [title trim];
    if ( title.length == 0 || CGSizeEqualToSize(size, CGSizeZero) ) {
        self.navigationItem.leftBarButtonItem = nil;
        return nil;
    } else {
        UIButton *btn = AWCreateTextButton(CGRectMake(0, 0, size.width, size.height),
                                           title,
                                           nil,
                                           self,
                                           @selector(btnClicked:));
        btn.tag = kNavBarLeftItemTag;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        return btn;
    }
}

- (UIView *)addRightBarItemWithTitle:(NSString *)title size:(CGSize)size callback:(void (^)(void))callback
{
    self.rightItemCallback = callback;
    
    title = [title trim];
    if ( title.length == 0 || CGSizeEqualToSize(size, CGSizeZero) ) {
        self.navigationItem.leftBarButtonItem = nil;
        return nil;
    } else {
        UIButton *btn = AWCreateTextButton(CGRectMake(0, 0, size.width, size.height),
                                           title,
                                           nil,
                                           self,
                                           @selector(btnClicked:));
        btn.tag = kNavBarRightItemTag;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        return btn;
    }
}

- (void)btnClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case kNavBarLeftItemTag: {
            if ( self.leftItemCallback ) {
                self.leftItemCallback();
            }
        }
            break;
        case kNavBarRightItemTag: {
            if ( self.rightItemCallback ) {
                self.rightItemCallback();
            }
        }
            break;
            
        default:
            break;
    }
}

@end
