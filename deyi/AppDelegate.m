//
//  AppDelegate.m
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "AppDelegate.h"
#import "Defines.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)load
{
    // 设置缓存大小
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                         diskCapacity:100 * 1024 * 1024
                                                             diskPath:@"Images"];
    [NSURLCache setSharedURLCache:urlCache];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"network status: %d", status);
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSFontAttributeName : AWCustomFont(MAIN_TEXT_FONT, 18),
                                                            NSForegroundColorAttributeName : MAIN_BLACK_COLOR }];
    [[UINavigationBar appearance] setBackgroundImage:AWImageFromColor([UIColor whiteColor])
                                       forBarMetrics:UIBarMetricsDefault];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    User *currentUser = [[UserService sharedInstance] currentUser];
    UIViewController *rootVC = !!currentUser ?
    [[NSClassFromString(@"HomeVC") alloc] init] :
    [[NSClassFromString(@"LoginVC") alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
//    [self deterNetworkType];
    
    NSLog(@"1234567 -> %.04f", 3.55);

    return YES;
}

//- (void)deterNetworkType
//{
//    UIApplication *app = [UIApplication sharedApplication];
//    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
//    NSNumber *dataNetworkItemView = nil;
//    
//    for (id subview in subviews) {
//        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
//            dataNetworkItemView = subview;
//            break;
//        }
//    }
//
//    NSNumber *type = [dataNetworkItemView valueForKey:@"dataNetworkType"];
//    NSLog(@"type: %@, %@", type, [[AWNetworkManager sharedInstance] currentNetworkType]);
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
