//
//  Shipment.h
//  deyi
//
//  Created by tomwey on 9/5/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shipment : NSObject <NSSecureCoding>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *mobile;
@property (nonatomic, copy, readonly) NSString *address;

- (instancetype)initWithDictionary:(NSDictionary *)jsonResult;

@end
