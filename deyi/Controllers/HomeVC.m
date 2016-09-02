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

@end

#define kSectionMargin 10

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"得益";
    
    __weak typeof(self) me = self;
    [self addRightBarItemWithImage:@"btn_settings.png" callback:^{
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
                                           @"00000",
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
        
        UIImageView *iconView = AWCreateImageView(module.icon);
        iconView.frame = CGRectMake(0, 0, 32, 32);
        [gridView addSubview:iconView];
        iconView.center = CGPointMake(gridView.width / 2, 20 + iconView.height / 2);
        
        CGRect frame = CGRectMake(0, gridView.height - 10 - 37, gridView.width, 37);
        UILabel *nameLabel = AWCreateLabel(frame, module.name,
                                           NSTextAlignmentCenter,
                                           AWCustomFont(MAIN_TEXT_FONT, 16),
                                           MAIN_BLACK_COLOR);
        [gridView addSubview:nameLabel];
        
        gridView.tag = i;
        
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

- (void)gotoSettings
{
    
}

- (void)gridDidTap:(UIGestureRecognizer *)gesture
{
    NSInteger index = gesture.view.tag;
    
    Module *m = [[self.moduleService loadModules] objectAtIndex:index];
    
    WebViewVC *http = [[WebViewVC alloc] initWithTitle:@"标题" link:@"https://www.baidu.com"];
    [self.navigationController pushViewController:http animated:YES];
    
    NSLog(@"index: %d", index);
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

@end
