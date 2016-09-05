//
//  LocationView.m
//  deyi
//
//  Created by tangwei1 on 16/9/5.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "LocationView.h"
#import "Defines.h"

@interface LocationView ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel     *locationLabel;

@property (nonatomic, assign, readwrite) LocationStatus currentLocationStatus;

@end
@implementation LocationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, 0, 44);
        
        self.iconView = AWCreateImageView(@"icon_navbar_location.png");
        [self addSubview:self.iconView];
        self.iconView.position = CGPointMake(0, self.height / 2 - self.iconView.height / 2);
        
        self.locationLabel = AWCreateLabel(CGRectZero,
                                           nil,
                                           NSTextAlignmentLeft,
                                           AWCustomFont(MAIN_TEXT_FONT,
                                                        16),
                                           MAIN_BLACK_COLOR);
        [self addSubview:self.locationLabel];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(relocate)]];
        
        self.userInteractionEnabled = NO;
        
        self.currentLocationStatus = LocationStatusDefault;
    }
    return self;
}

- (void)relocate
{
    if ( self.reloadLocateCallback ) {
        self.reloadLocateCallback();
    }
}

- (void)setLocationStatus:(LocationStatus)status message:(NSString *)message
{
    if ( status == LocationStatusLocateError ||
        status == LocationStatusParseError) {
        self.userInteractionEnabled = YES;
    } else {
        self.userInteractionEnabled = NO;
    }
    
    self.currentLocationStatus = status;
    
    NSString *text = message;
    if ( status == LocationStatusParseError || status == LocationStatusLocateError ) {
        text = [NSString stringWithFormat:@"%@，点击重试", message];
    }
    
    self.locationLabel.text = text;
    [self.locationLabel sizeToFit];
    
    self.width = self.iconView.width + 10 + self.locationLabel.width;
    self.locationLabel.position = CGPointMake(self.iconView.right + 10, self.height / 2 - self.locationLabel.height / 2);
}

@end
