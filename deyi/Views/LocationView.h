//
//  LocationView.h
//  deyi
//
//  Created by tangwei1 on 16/9/5.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LocationStatus) {
    LocationStatusDefault,     // 初始化时的状态
    LocationStatusLocating,    // 定位中
    LocationStatusParsing,     // 位置解析中
    LocationStatusLocateError, // 定位失败
    LocationStatusParseError,  // 逆编码失败
    LocationStatusSuccess,     // 位置获取成功
};

@interface LocationView : UIView

- (void)setLocationStatus:(LocationStatus)status message:(NSString *)message;
@property (nonatomic, assign, readonly) LocationStatus currentLocationStatus;

/** 如果定位失败，或者解析位置失败，需要重新定位，有可能会导致循环引用 */
@property (nonatomic, copy) void (^reloadLocateCallback)(void);



@end
