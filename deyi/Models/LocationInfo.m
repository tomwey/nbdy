//
//  LocationInfo.m
//  deyi
//
//  Created by tangwei1 on 16/9/5.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "LocationInfo.h"

@interface LocationInfo ()

@property (nonatomic, copy, readwrite) NSString *nation;
@property (nonatomic, copy, readwrite) NSString *province;
@property (nonatomic, copy, readwrite) NSString *city;
@property (nonatomic, copy, readwrite) NSString *district;
@property (nonatomic, copy, readwrite) NSString *address;
@property (nonatomic, copy, readwrite) NSString *adcode;

@property (nonatomic, copy, readwrite) NSString *landmarkL1;
@property (nonatomic, copy, readwrite) NSString *landmarkL2;

@property (nonatomic, copy, readwrite) NSString *formatedAddress;

@property (nonatomic, strong, readwrite) CLLocation *location;

@end
@implementation LocationInfo

- (instancetype)initWithDictionary:(NSDictionary *)jsonResult
{
    if ( self = [super init] ) {
        self.nation = jsonResult[@"ad_info"][@"nation"];
        self.province = jsonResult[@"ad_info"][@"province"];
        self.city = jsonResult[@"ad_info"][@"city"];
        self.district = jsonResult[@"ad_info"][@"district"];
        self.adcode = jsonResult[@"ad_info"][@"adcode"];
        self.address = jsonResult[@"address"];
        
        self.landmarkL1 = jsonResult[@"address_reference"][@"landmark_l1"][@"title"];
        self.landmarkL2 = jsonResult[@"address_reference"][@"landmark_l2"][@"title"];
        
        self.formatedAddress = jsonResult[@"formatted_addresses"];
        NSDictionary *location = jsonResult[@"ad_info"][@"location"];
        self.location = [[CLLocation alloc] initWithLatitude:[location[@"lat"] doubleValue]
                                                   longitude:[location[@"lng"] doubleValue]];
    }
    return self;
}

@end