//
//  HomeVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "HomeVC.h"
#import "Defines.h"

@interface HomeVC ()

@property (nonatomic, strong) UIScrollView *sectionContainer;

@property (nonatomic, strong) UIView *wifiSection;
@property (nonatomic, strong) UIView *earningsSection;

@property (nonatomic, strong, readonly) UILabel *todayEarnLabel;
@property (nonatomic, strong, readonly) UILabel *totalEarnLabel;
@property (nonatomic, strong, readonly) UILabel *balanceLabel;

@property (nonatomic, strong) ModuleService *moduleService;

@property (nonatomic, strong) LocationView *locationView;

@property (nonatomic, strong) LocationService *locationService;

@property (nonatomic, strong) NetworkService  *loadEarnsService;

@property (nonatomic, strong) NetworkService  *loadUnreadMessageService;

@property (nonatomic, strong) UIView *redDot;

@property (nonatomic, weak) UIView *settingsButton;

@end

#define kSectionMargin 10

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"得益";
    
    __weak typeof(self) me = self;
    
    // 添加位置视图
    self.locationView = [[LocationView alloc] init];
    [self addLeftBarItemWithView:self.locationView];
    self.locationView.reloadLocateCallback = ^{
        [me fetchLocation];
    };
    
    self.settingsButton = [self addRightBarItemWithImage:@"btn_settings.png" callback:^{
        [me gotoSettings];
    }];
    
    // 创建内容容器
    self.sectionContainer = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.sectionContainer];
    self.sectionContainer.top = 0;
    self.sectionContainer.showsHorizontalScrollIndicator =
    self.sectionContainer.showsVerticalScrollIndicator   = NO;
    
    // 初始化wifi区域
    [self initWIFISection];
    
    // 初始化收益区域
    [self initEarningsSection];
    
    // 初始化功能区域
    [self initModuleSection];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadInfo)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadInfo];
        
        NSLog(@"device info: %@", APIDeviceParams());
    });
}

- (void)loadInfo
{
    // 获取位置信息
    [self fetchLocation];
    
    // 加载收入信息
    [self fetchEarnings];
    
    // 加载未读消息
    [self fetchUnreadMessageCount];
}

- (void)initWIFISection
{
    self.wifiSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 96)];
    [self.sectionContainer addSubview:self.wifiSection];
    self.wifiSection.backgroundColor = [UIColor whiteColor];
    
    // wifi指示标志
    UIImageView *wifiIndicator = AWCreateImageView(@"icon_home_wifi_indicator_open.png");
    [self.wifiSection addSubview:wifiIndicator];
    wifiIndicator.frame = CGRectMake(15, 15, 80, 66);
    
    // 一键连接得益WIFI
    CGFloat width = self.contentView.width * 0.56;
    CGRect frame = CGRectMake(self.contentView.width - wifiIndicator.left - width ,
                              self.wifiSection.height / 2 - 44 / 2,
                              width,
                              44);
    UIButton *btn = AWCreateTextButton(frame, @"一键连接得益WIFI", [UIColor whiteColor],
                                       self,
                                       @selector(connectWIFI));
    [self.wifiSection addSubview:btn];
    btn.cornerRadius = 8;
    btn.backgroundColor = MAIN_RED_COLOR;
    
    self.sectionContainer.contentSize = CGSizeMake(self.contentView.width, self.wifiSection.bottom);
}

- (void)initEarningsSection
{
    self.earningsSection = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                    self.wifiSection.bottom + kSectionMargin,
                                                                    self.contentView.width,
                                                                    88)];
    [self.sectionContainer addSubview:self.earningsSection];
    self.earningsSection.backgroundColor = [UIColor whiteColor];
    
    NSArray *tips = @[@"今日收益", @"总共收益", @"益豆余额"];
    CGFloat width = ceilf(self.contentView.width / tips.count);
    for (int i = 0; i < tips.count; i++) {
        CGRect frame = CGRectMake(width * i, 10, width, 34);
        UILabel *headLabel = AWCreateLabel(frame,
                                       tips[i],
                                       NSTextAlignmentCenter,
                                       AWCustomFont(MAIN_TEXT_FONT,
                                                    16),
                                       MAIN_BLACK_COLOR);
        [self.earningsSection addSubview:headLabel];
        
        CGRect frame2 = CGRectMake(width * i, headLabel.bottom, width, 34);
//        frame2 = CGRectInset(frame2, 15, 0);
        UILabel *earnLabel = AWCreateLabel(frame2,
                                           @"--",
                                           NSTextAlignmentCenter,
                                           AWCustomFont(MAIN_DIGIT_FONT,
                                                        24),
                                           MAIN_RED_COLOR);
        [self.earningsSection addSubview:earnLabel];
        earnLabel.adjustsFontSizeToFitWidth = YES;
        earnLabel.tag = 10000 + i;
        
        if ( i < 2 ) {
            UILabel *unitLabel = AWCreateLabel(CGRectZero,
                                           @"( 益豆 )",
                                           NSTextAlignmentLeft,
                                           AWCustomFont(MAIN_TEXT_FONT, 8),
                                           MAIN_BLACK_COLOR);
            [unitLabel sizeToFit];
            [self.earningsSection addSubview:unitLabel];
            unitLabel.position = CGPointMake(headLabel.midX + 35, headLabel.midY + 3 - unitLabel.height / 2);
        }
    }
}

- (void)initModuleSection
{
    NSArray *modules = [self.moduleService loadModules];
    NSInteger numberOfCols = self.contentView.width > 320 ? 4 : 3;
    CGFloat width = ceilf(self.contentView.width / numberOfCols);
    
    NSInteger numberOfRows = ( modules.count + numberOfCols - 1 ) / numberOfCols;
//    CGFloat height = 0;
    for (int i = 0; i < modules.count; i++) {
        UIView *gridView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        gridView.backgroundColor = [UIColor whiteColor];
        [self.sectionContainer addSubview:gridView];
        gridView.clipsToBounds = YES;
        
        int m = i % numberOfCols;
        int n = i / numberOfCols;
        CGFloat dtx = m * width;
        CGFloat dty = self.earningsSection.bottom + kSectionMargin + n * width;
        
        gridView.position = CGPointMake(dtx, dty);
        
        Module *module = [modules objectAtIndex:i];
        
        CGFloat iconHeight = 32;
        CGFloat nameLabelHeight = 30;
        UIImageView *iconView = AWCreateImageView(module.icon);
        iconView.frame = CGRectMake(0, 0, iconHeight, iconHeight);
        [gridView addSubview:iconView];
        
        CGRect frame = CGRectMake(0, iconView.bottom, gridView.width, nameLabelHeight);
        UILabel *nameLabel = AWCreateLabel(frame, module.name,
                                           NSTextAlignmentCenter,
                                           AWCustomFont(MAIN_TEXT_FONT, 16),
                                           MAIN_BLACK_COLOR);
        [gridView addSubview:nameLabel];
        
        [nameLabel sizeToFit];
        
        gridView.tag = i;
        
        CGFloat totalHeight = iconHeight + nameLabel.height;
        CGFloat top = ( gridView.height - totalHeight ) / 3;
        
        iconView.top = top;
        iconView.left = gridView.width / 2 - iconView.width / 2;
        
        nameLabel.center = CGPointMake(gridView.width / 2, iconView.bottom + top + nameLabel.height / 2);
        
        [gridView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gridDidTap:)]];
        
        if ( i == modules.count - 1 ) {
            self.sectionContainer.contentSize = CGSizeMake(self.contentView.width, gridView.bottom);
        }
        
        if ( m != numberOfCols - 1 ) {
            AWHairlineView *rightLine = [[AWHairlineView alloc] initWithLineColor:HOME_HAIRLINE_COLOR];
            rightLine.frame = CGRectMake(gridView.width - 1, -1, 1, gridView.height + 1);
            [gridView addSubview:rightLine];
        }
        
        if ( n != numberOfRows - 1 ) {
            AWHairlineView *bottomLine = [[AWHairlineView alloc] initWithLineColor:HOME_HAIRLINE_COLOR];
            bottomLine.frame = CGRectMake( -1, gridView.height - 1, gridView.width + 1, 1);
            [gridView addSubview:bottomLine];
        }
        
    }
}

- (void)connectWIFI
{
    
}

- (void)handleLocationParse:(id)result error:(NSError *)error
{
    if ( error ) {
        [self.locationView setLocationStatus:LocationStatusParseError message:@"点击重新定位"];
    } else {
        NSLog(@"result: %@", result);
        [self.locationView setLocationStatus:LocationStatusSuccess message:[result city]];
    }
}

- (void)startFetchingLocation
{
    [[AWLocationManager sharedInstance] startUpdatingLocation:^(CLLocation *location, NSError *error) {
        if ( error ) {
            [self.locationView setLocationStatus:LocationStatusLocateError message:@"点击重新定位"];
            if ( error.code == AWLocationErrorDenied ) {
                NSString *message = [NSString stringWithFormat:@"请到设置->隐私->定位服务中开启【%@】定位服务，以便能够准确获得您的位置信息",
                                     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
                [[[UIAlertView alloc] initWithTitle:@"定位服务关闭"
                                           message:message
                                          delegate:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil] show];
            }
        } else {
            [self.locationView setLocationStatus:LocationStatusParsing message:@"位置解析中"];
            
            [self startParsingLocation:location];
        }
    }];
}

- (void)startParsingLocation:(CLLocation *)location
{
    if (!location) return;
    
    __weak typeof(self) me = self;
    [self.locationService parseLocation:location completion:^(id result, NSError *error) {
        [me handleLocationParse:result error:error];
    }];
}

- (void)fetchEarnings
{
    [SpinnerView showSpinnerInView:nil];
    [self.loadEarnsService GET:API_V1_LOAD_EARNINGS
                        params:@{ @"token": [[UserService sharedInstance] currentUserAuthToken] }
                    completion:^(id result, NSError *error) {
                        NSLog(@"result: %@", result);
                        [SpinnerView hideSpinnerForView:nil];
                        if ( !error ) {
                            self.todayEarnLabel.text = [result[@"today"] description];
                            self.totalEarnLabel.text = [result[@"total"] description];
                            self.balanceLabel.text   = [result[@"balance"] description];
                        }
                    }];
}

- (void)fetchUnreadMessageCount
{
    [self.loadUnreadMessageService GET:API_V1_LOAD_UNREAD_MESSAGE_COUNT
                                params:@{ @"token": [[UserService sharedInstance] currentUserAuthToken] }
                            completion:^(id result, NSError *error) {
                                NSLog(@"result: %@", result);
                                if (error) {
                                    self.redDot.hidden = YES;
                                } else {
                                    if ( [result[@"count"] integerValue] > 0 ) {
                                        self.redDot.hidden = NO;
                                    } else {
                                        self.redDot.hidden = YES;
                                    }
                                }
                            }];
}

- (void)fetchLocation
{
    LocationStatus status = self.locationView.currentLocationStatus;
    switch (status) {
        case LocationStatusDefault:
        {
            [self.locationView setLocationStatus:LocationStatusLocating message:@"定位中"];
            
            [self startFetchingLocation];
        }
            break;
        case LocationStatusLocateError:
        {
            [self.locationView setLocationStatus:LocationStatusLocating message:@"定位中"];
            
            [self startFetchingLocation];
        }
            break;
        case LocationStatusParseError:
        {
            [self.locationView setLocationStatus:LocationStatusLocating message:@"位置解析中"];
            
            [self startParsingLocation:[[AWLocationManager sharedInstance] currentLocation]];
        }
            break;
            
        default:
            break;
    }
}

- (void)gotoSettings
{
    UIViewController *vc =
    [[AWMediator sharedInstance] openVCWithName:@"SettingsVC" params:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gridDidTap:(UIGestureRecognizer *)gesture
{
    NSInteger index = gesture.view.tag;
    
    Module *m = [[self.moduleService loadModules] objectAtIndex:index];
    if ( m.pageClassName.length == 0 ) {
        // 签到
        [self gotoCheckin];
    } else {
        UIViewController *vc = [[AWMediator sharedInstance] openVCWithName:m.pageClassName params:m.params];
        vc.title = m.name;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)gotoCheckin
{
    [self.loadEarnsService POST:API_V1_CHECKIN
                         params:@{ @"token" : [[UserService sharedInstance] currentUserAuthToken],
                                   @"loc" : [[AWLocationManager sharedInstance] formatedCurrentLocation_1] ?: @"" }
                     completion:^(id result, NSError *error) {
                         if ( error ) {
                             
                         } else {
                             
                         }
                     }];
}

- (ModuleService *)moduleService
{
    if ( !_moduleService ) {
        _moduleService = [[ModuleService alloc] init];
    }
    return _moduleService;
}

- (UILabel *)todayEarnLabel
{
    return (UILabel *)[self.earningsSection viewWithTag:10000];
}

- (UILabel *)totalEarnLabel
{
    return (UILabel *)[self.earningsSection viewWithTag:10001];
}

- (UILabel *)balanceLabel
{
    return (UILabel *)[self.earningsSection viewWithTag:10002];
}

- (UIView *)redDot
{
//    if ( !_redDot ) {
//        _redDot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
//        _redDot.backgroundColor = MAIN_RED_COLOR;
//        
//        
//    }
    return nil;
}

- (LocationService *)locationService
{
    if ( !_locationService ) {
        _locationService = [[LocationService alloc] init];
    }
    return _locationService;
}

- (NetworkService *)loadEarnsService
{
    if ( !_loadEarnsService ) {
        _loadEarnsService = [[NetworkService alloc] init];
    }
    return _loadEarnsService;
}

- (NetworkService *)loadUnreadMessageService
{
    if ( !_loadUnreadMessageService ) {
        _loadUnreadMessageService = [[NetworkService alloc] init];
    }
    return _loadUnreadMessageService;
}

@end
