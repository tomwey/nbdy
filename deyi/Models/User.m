//
//  User.m
//  deyi
//
//  Created by tomwey on 9/5/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "User.h"
#import "Shipment.h"

@interface User ()

@property (nonatomic, copy, readwrite) NSString *nickname;
@property (nonatomic, copy, readwrite) NSString *uid;
@property (nonatomic, copy, readwrite) NSString *token;
@property (nonatomic, copy, readwrite) NSString *avatar;
@property (nonatomic, copy, readwrite) NSString *nbcode;

@property (nonatomic, strong, readwrite) NSNumber *bean;
@property (nonatomic, strong, readwrite) NSNumber *balance;

@property (nonatomic, copy, readwrite) NSString *qrcodeUrl;

@property (nonatomic, strong, readwrite) Shipment *currentShipment;

@end
@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)jsonResult
{
    if ( self = [super init] ) {
        self.nickname = jsonResult[@"nickname"];
        self.uid      = jsonResult[@"uid"];
        self.token    = jsonResult[@"token"];
        self.avatar   = jsonResult[@"avatar"];
        self.nbcode   = jsonResult[@"nb_code"];
        
        self.bean     = jsonResult[@"bean"];
        self.balance  = jsonResult[@"balance"];
        
        self.qrcodeUrl = jsonResult[@"qrcode_url"];
        
        if ( jsonResult[@"shipment"] ) {
            self.currentShipment = [[Shipment alloc] initWithDictionary:jsonResult[@"shipment"]];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.nbcode forKey:@"nb_code"];
    [aCoder encodeObject:self.bean forKey:@"bean"];
    [aCoder encodeObject:self.balance forKey:@"balance"];
    [aCoder encodeObject:self.qrcodeUrl forKey:@"qrcode_url"];
    [aCoder encodeObject:self.currentShipment forKey:@"shipment"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    User *user = [[User alloc] init];
    
    user.nickname = [[aDecoder decodeObjectForKey:@"nickname"] description];
    user.uid = [[aDecoder decodeObjectForKey:@"uid"] description];
    user.token = [[aDecoder decodeObjectForKey:@"token"] description];
    user.avatar = [[aDecoder decodeObjectForKey:@"avatar"] description];
    user.nbcode = [[aDecoder decodeObjectForKey:@"nb_code"] description];
    user.bean = [aDecoder decodeObjectForKey:@"bean"];
    user.balance = [aDecoder decodeObjectForKey:@"balance"];
    user.qrcodeUrl = [[aDecoder decodeObjectForKey:@"qrcode_url"] description];
    user.currentShipment = [aDecoder decodeObjectForKey:@"shipment"];
    
    return user;
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

@end
