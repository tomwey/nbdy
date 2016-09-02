//
//  Module.m
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "Module.h"

@interface Module ()

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *icon;
@property (nonatomic, copy, readwrite) NSString *pageClassName;

@end
@implementation Module

- (instancetype)initWithName:(NSString *)name
                        icon:(NSString *)icon
               pageClassName:(NSString *)className
{
    if ( self = [super init] ) {
        self.name = name;
        self.icon = icon;
        self.pageClassName = className;
    }
    return self;
}

@end
