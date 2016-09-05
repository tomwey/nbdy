//
//  LocationInfo.h
//  deyi
//
//  Created by tangwei1 on 16/9/5.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationInfo : NSObject

@property (nonatomic, copy, readonly) NSString *nation;
@property (nonatomic, copy, readonly) NSString *province;
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *district;
@property (nonatomic, copy, readonly) NSString *address;
@property (nonatomic, copy, readonly) NSString *adcode;

@property (nonatomic, copy, readonly) NSString *landmarkL1;
@property (nonatomic, copy, readonly) NSString *landmarkL2;

@property (nonatomic, copy, readonly) NSString *formatedAddress;

@property (nonatomic, strong, readonly) CLLocation *location;

- (instancetype)initWithDictionary:(NSDictionary *)jsonResult;

@end

