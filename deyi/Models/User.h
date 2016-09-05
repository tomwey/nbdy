//
//  User.h
//  deyi
//
//  Created by tomwey on 9/5/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Shipment;
@interface User : NSObject <NSSecureCoding>

@property (nonatomic, copy, readonly) NSString *nickname;
@property (nonatomic, copy, readonly) NSString *uid;
@property (nonatomic, copy, readonly) NSString *token;
@property (nonatomic, copy, readonly) NSString *avatar;
@property (nonatomic, copy, readonly) NSString *nbcode;

@property (nonatomic, strong, readonly) NSNumber *bean;
@property (nonatomic, strong, readonly) NSNumber *balance;

@property (nonatomic, copy, readonly) NSString *qrcodeUrl;

@property (nonatomic, strong, readonly) Shipment *currentShipment;

- (instancetype)initWithDictionary:(NSDictionary *)jsonResult;

@end
