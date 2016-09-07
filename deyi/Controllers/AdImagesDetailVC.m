//
//  AdImagesDetailVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/7.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "AdImagesDetailVC.h"
#import "Defines.h"

@implementation AdImagesDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.params[@"item"][@"title"];
}

@end
