//
//  Module.h
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Module : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *icon;
@property (nonatomic, copy, readonly) NSString *pageClassName;
@property (nonatomic, copy, readonly) NSDictionary *params;

- (instancetype)initWithName:(NSString *)name
                        icon:(NSString *)icon
               pageClassName:(NSString *)className
                      params:(NSDictionary *)params;

@end
