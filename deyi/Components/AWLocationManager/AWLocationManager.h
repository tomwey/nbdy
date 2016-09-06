//
//  AWLocationManager.h
//  deyi
//
//  Created by tangwei1 on 16/9/5.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, AWLocationError) {
    AWLocationErrorUnknown    = -1, // 未知错误
    AWLocationErrorNotEnabled = 0,  // 定位功能服务无效
    AWLocationErrorNotDetermined,   // 用户没有选择是否运行使用定位
    AWLocationErrorRestricted,      // 限制使用定位
    AWLocationErrorDenied,          // 不允许使用定位
};

@interface AWLocationManager : NSObject

/** 返回当前最新的位置 */
@property (nonatomic, strong, readonly) CLLocation *currentLocation;

+ (AWLocationManager *)sharedInstance;

/**
 * 开始定位，如果需要重新定位，可以多次调用
 * 
 * @param completionBlock 定位完成的回调
 */
- (void)startUpdatingLocation:(void (^)(CLLocation *location, NSError *error))completionBlock;

/**
 * 重新定位
 *
 * @param completionBlock 定位完成的回调
 */
//- (void)restartUpdatingLocation:(void (^)(CLLocation *location, NSError *error))completionBlock;

/**
 * 停止定位，释放定位资源
 */
- (void)stopUpdatingLocation;

/** 返回当前位置的经纬度格式化字符串，格式为：经度,纬度 */
- (NSString *)formatedCurrentLocation_1;

/** 返回当前位置的经纬度格式化字符串，格式为：纬度,经度 */
- (NSString *)formatedCurrentLocation_2;

@end
