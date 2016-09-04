//
//  SpinnerView.m
//  deyi
//
//  Created by tomwey on 9/4/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "SpinnerView.h"
#import "Defines.h"

@interface SpinnerView ()

@property (nonatomic, strong) UIImageView *loadingView;

@end

@implementation SpinnerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame] ) {
        
        self.frame = CGRectMake(0, 0, 80, 80);
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
        
        self.loadingView = AWCreateImageView(nil);
        self.loadingView.frame = CGRectMake(0, 0, 60, 50);
        [self addSubview:self.loadingView];
        
        self.loadingView.center = CGPointMake(self.width / 2, self.height / 2);
        
        self.loadingView.animationImages = @[
                                             [UIImage imageNamed:@"loading_1.png"],
                                             [UIImage imageNamed:@"loading_2.png"],
                                             [UIImage imageNamed:@"loading_3.png"],
                                             [UIImage imageNamed:@"loading_4.png"],
                                             ];
        self.loadingView.animationDuration = 0.8;
    }
    return self;
}

+ (void)showSpinnerInView:(UIView *)parent
{
    SpinnerView *spinnerView = [[SpinnerView alloc] init];
    [parent addSubview:spinnerView];
    
    spinnerView.tag = 1010112;
    
    spinnerView.center = CGPointMake(parent.width / 2, parent.height / 2);
    
    [parent bringSubviewToFront:spinnerView];
    
    parent.userInteractionEnabled = NO;
    
    if ( [spinnerView.loadingView isAnimating] == NO ) {
        [spinnerView.loadingView startAnimating];
    }
}

+ (void)hideSpinnerForView:(UIView *)parent
{
    parent.userInteractionEnabled = YES;
    
    SpinnerView *spinner = [parent viewWithTag:1010112];
    
    [spinner.loadingView stopAnimating];
    
    [spinner removeFromSuperview];
}

@end
