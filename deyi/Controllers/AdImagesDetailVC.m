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

@property (nonatomic, strong) UILabel *pageNumLabel;

@property (nonatomic, strong) NetworkService *sendDataService;

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
    
    [self scrollToPage:0];
}

- (void)scrollToPage:(NSInteger)index
{
    NSLog(@"page index: %d", index);
    NSInteger pageNo = index + 1;
    if ( pageNo < 1 ) {
        pageNo = 1;
    }
    
    if ( pageNo > self.adImages.count ) {
        pageNo = self.adImages.count;
    }
    
    self.pageNumLabel.text = [NSString stringWithFormat:@"%d / %d", pageNo, self.adImages.count];
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

- (void)sendDataToServer
{
    NSMutableDictionary *params = [APIDeviceParams() mutableCopy];
    [params setObject:[[UserService sharedInstance] currentUserAuthToken] forKey:@"token"];
    [params setObject:self.params[@"item"][@"id"] ?: @"0" forKey:@"ad_id"];
    [params setObject:[[AWLocationManager sharedInstance] formatedCurrentLocation_1] forKey:@"loc"];
    
    [self.sendDataService POST:API_V1_AD_VIEW params:params completion:^(id result, NSError *error) {
        if ( !error ) {
            //            NSLog(@"成功浏览广告");
            NSInteger earn = [self.params[@"item"][@"price"] intValue];
            [SuccessMessagePanel showWithTitle:@"广告任务" taskName:@"浏览商家广告" earn:earn];
        } else {
            NSLog(@"失败浏览广告");
            [FailureMessagePanel showWithTitle:@"广告任务" message:@"浏览商家广告失败" footerButtonTitle:@"确定"];
        }
    }];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    if ( completed ) {
        ImageVC *vc = (ImageVC *)[pageViewController.viewControllers firstObject];
        [self scrollToPage:vc.pageIndex];
        
        if ( vc.pageIndex == self.adImages.count - 1 ) {
            // 发送统计信息到服务器
            [self sendDataToServer];
        }
    }
}

#pragma mark --------------------------------------------------------------------------------
#pragma mark UIPageViewController dataSource
#pragma mark --------------------------------------------------------------------------------
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ( self.adImages.count == 1 ) return nil;
    
    ImageVC *vc = (ImageVC *)viewController;
    NSInteger index = vc.pageIndex - 1;
    
    if ( index < 0 ) {
        return nil;
    }
    
    return [self setViewControllerAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                viewControllerAfterViewController:(UIViewController *)viewController
{
    if ( self.adImages.count == 1 ) return nil;
    
    ImageVC *vc = (ImageVC *)viewController;
    NSInteger index = vc.pageIndex + 1;
    
    if ( index == self.adImages.count ) {
        return nil;
    }
    
    return [self setViewControllerAtIndex:index];
}

#pragma mark --------------------------------------------------------------------------------
#pragma mark Getters
#pragma mark --------------------------------------------------------------------------------

- (NetworkService *)sendDataService
{
    if ( !_sendDataService ) {
        _sendDataService = [[NetworkService alloc] init];
    }
    return _sendDataService;
}

- (UILabel *)pageNumLabel
{
    if ( !_pageNumLabel ) {
        UIView *pageNumContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        pageNumContainer.backgroundColor = [UIColor blackColor];
        pageNumContainer.alpha = 0.8;
        pageNumContainer.cornerRadius = 8;
        pageNumContainer.clipsToBounds = YES;
        [self.contentView addSubview:pageNumContainer];
        pageNumContainer.position = CGPointMake(self.contentView.width - pageNumContainer.width - 10,
                                                self.contentView.height - pageNumContainer.height - 10);
        
        _pageNumLabel = AWCreateLabel(pageNumContainer.frame,
                                      nil,
                                      NSTextAlignmentCenter,
                                      AWCustomFont(MAIN_DIGIT_FONT,
                                                   14),
                                      [UIColor whiteColor]);
        [self.contentView addSubview:_pageNumLabel];
    }
    return _pageNumLabel;
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
