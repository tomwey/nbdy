//
//  ParamsUtil.m
//  deyi
//
//  Created by tangwei1 on 16/9/7.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "ParamsUtil.h"
#import "Defines.h"

NSDictionary *APIPaginationParams(NSUInteger pageNo, NSUInteger pageSize)
{
    pageNo = MAX(pageNo, 1);
    
    pageSize = MIN(100, pageSize);
    pageSize = MAX(pageSize, 15);
    
    return @{
             @"page": @(pageNo),
             @"size": @(pageSize)
             };
}

NSDictionary *APIAuthParams()
{
    NSInteger i = [[NSDate date] timeIntervalSince1970];
    NSString *ak = [NSString stringWithFormat:@"%@%d", API_KEY, i];
    NSData *data = [ak dataUsingEncoding:NSUTF8StringEncoding];
    ak = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"ak: %@", ak);
    return @{
             @"i": [@(i) description],
             @"ak": ak,
             };
}

NSDictionary *APIDeviceParams()
{
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];

    NSString *nt = @"";
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
            nt = @"unknown";
            break;
        case AFNetworkReachabilityStatusNotReachable:
            nt = @"none";
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            nt = @"wifi";
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            nt = @"wan";
            break;
            
        default:
            break;
    }
    return @{
             @"udid": [[[UIDevice currentDevice] identifierForVendor] UUIDString],
             @"m": AWDeviceName(),
             @"pl": [[UIDevice currentDevice] systemName],
             @"osv": AWOSVersionString(),
             @"bv": AWAppVersion(),
             @"sr": AWDeviceSizeString(),
             @"cl": AWDeviceCountryLangCode(),
             @"nt": nt,
             @"bb": @(0),
             };
}