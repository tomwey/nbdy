//
//  AdImagesDetailVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/7.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "AdImagesDetailVC.h"
#import "Defines.h"

@interface ImageVC : UIViewController

+ (instancetype)viewControllerAtIndex:(NSInteger)index;

@property (nonatomic, assign, readonly) NSInteger pageIndex;

@property (nonatomic, copy) NSString *imageUrl;

@end

@interface AdImagesDetailVC () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, copy) NSArray *adImages;

@end

@implementation AdImagesDetailVC

- (void)dealloc
{
    self.pageViewController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.params[@"item"][@"title"];
    
    self.adImages = self.params[@"item"][@"ad_contents"];
    
    [self.pageViewController setViewControllers:@[[self setViewControllerAtIndex:0]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    self.pageViewController.view.frame = self.contentView.bounds;
    [self addChildViewController:self.pageViewController];
    [self.contentView addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (ImageVC *)setViewControllerAtIndex:(NSInteger)index
{
    if ( index >= self.adImages.count || index < 0 ) {
        return nil;
    }
    
    ImageVC *vc = [ImageVC viewControllerAtIndex:index];
    vc.imageUrl = self.adImages[index];
    return vc;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerBeforeViewController:(UIViewController *)viewController
{
    ImageVC *vc = (ImageVC *)viewController;
    NSInteger index = vc.pageIndex;
    
    if ( index == 0 || index == NSNotFound ) {
        return nil;
    }
    index --;
    
    return [self setViewControllerAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                viewControllerAfterViewController:(UIViewController *)viewController
{
    ImageVC *vc = (ImageVC *)viewController;
    NSInteger index = vc.pageIndex;
    if ( index == NSNotFound ) {
        return nil;
    }
    
    index++;
    
    if ( index == self.adImages.count ) {
        return nil;
    }
    
    return [self setViewControllerAtIndex:index];
}

- (UIPageViewController *)pageViewController
{
    if ( !_pageViewController ) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
        _pageViewController.dataSource = self;
        _pageViewController.delegate   = self;
    }
    return _pageViewController;
}

@end

@interface ImageVC ()

- (instancetype)initWithPageIndex:(NSInteger)index;

@property (nonatomic, assign, readwrite) NSInteger pageIndex;

@end
@implementation ImageVC

- (instancetype)initWithPageIndex:(NSInteger)index
{
    if ( self = [super init] ) {
        self.pageIndex = index;
    }
    return self;
}

+ (instancetype)viewControllerAtIndex:(NSInteger)index
{
    return [[ImageVC alloc] initWithPageIndex:index];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = AWCreateImageView(nil);
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.view.backgroundColor = MAIN_BLACK_COLOR;
    
    [imageView setImageWithProgressIndicatorForURL:[NSURL URLWithString:self.imageUrl]];
}

@end
