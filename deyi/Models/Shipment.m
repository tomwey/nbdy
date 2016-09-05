//
//  Shipment.m
//  deyi
//
//  Created by tomwey on 9/5/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "Shipment.h"

@interface Shipment ()

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *mobile;
@property (nonatomic, copy, readwrite) NSString *address;

@end
@implementation Shipment

- (instancetype)initWithDictionary:(NSDictionary *)jsonResult
{
    if ( self = [super init] ) {
        self.name = jsonResult[@"name"];
        self.mobile = jsonResult[@"mobile"];
        self.address = jsonResult[@"address"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.address forKey:@"address"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    Shipment *shipment = [[Shipment alloc] init];
    
    shipment.name = [[aDecoder decodeObjectForKey:@"name"] description];
    shipment.mobile = [[aDecoder decodeObjectForKey:@"mobile"] description];
    shipment.address = [[aDecoder decodeObjectForKey:@"address"] description];
    
    return shipment;
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

@end
