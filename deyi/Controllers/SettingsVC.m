//
//  SettingsVC.m
//  deyi
//
//  Created by tomwey on 9/3/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "SettingsVC.h"
#import "Defines.h"

@interface SettingsVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *balanceLabel;

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) UILabel *nicknameLabel;

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds
                                                  style:UITableViewStylePlain];
    [self.contentView addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    self.tableView.backgroundColor = MAIN_BG_COLOR;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( section == 2 ) {
        return 7;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell.id"];
    if ( !cell ) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell.id"];
        
        if ( indexPath.section == 0 ) {
            [self addContentAtSection0:cell atIndexPath:indexPath];
        } else if ( indexPath.section == 1 ) {
            [self addContentAtSection1:cell atIndexPath:indexPath];
        }
    }
    
    if ( indexPath.section == 2 ) {
        NSArray *items = [self fetchSettingItems];
        id obj = items[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:obj[@"icon"]];
        
        cell.textLabel.text = obj[@"name"];
        cell.textLabel.font = AWCustomFont(MAIN_TEXT_FONT, 16);
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        if ( indexPath.section == 1 ) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section == 0 ) {
        return 64;
    }
    
    if ( indexPath.section == 1 ) {
        return 60;
    }
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)addContentAtSection0:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if ( !self.avatarView ) {
        self.avatarView = AWCreateImageView(nil);
        [cell.contentView addSubview:self.avatarView];
        
        self.avatarView.frame = CGRectMake(0, 0, 48, 48);
        
        self.avatarView.cornerRadius = self.avatarView.height / 2;
        
        self.avatarView.position = CGPointMake(15, 64 / 2 - self.avatarView.height / 2);
        
        self.avatarView.backgroundColor = HOME_HAIRLINE_COLOR;
    }
    
    if ( !self.nicknameLabel ) {
        CGRect frame = CGRectMake(self.avatarView.right + 15,
                                  self.avatarView.midY - 17,
                                  self.contentView.width -
                                  self.avatarView.right - 10 - 15 - 15, 34);
        
        self.nicknameLabel = AWCreateLabel(frame, @"昵称",
                                           NSTextAlignmentLeft,
                                           AWCustomFont(MAIN_TEXT_FONT, 16),
                                           MAIN_BLACK_COLOR);
        [cell.contentView addSubview:self.nicknameLabel];
    }
}

- (void)addContentAtSection1:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UILabel *myBalanceLabel = AWCreateLabel(CGRectMake(15, 14, 70, 34),
                                            @"我的益豆:",
                                            NSTextAlignmentLeft,
                                            AWCustomFont(MAIN_TEXT_FONT, 16),
                                            MAIN_BLACK_COLOR);
    [cell.contentView addSubview:myBalanceLabel];
    
    self.balanceLabel = AWCreateLabel(myBalanceLabel.frame,
                                          @"1389",
                                          NSTextAlignmentLeft,
                                          AWCustomFont(MAIN_DIGIT_FONT, 20),
                                          MAIN_RED_COLOR);
    [cell.contentView addSubview:self.balanceLabel];
    
    self.balanceLabel.left = myBalanceLabel.right + 10;
    self.balanceLabel.width = 200;
    
    // 添加一个提现按钮
    UIButton *withdrawButton =
        AWCreateTextButton(CGRectMake(0, 0, 88, 40),
                           @"立即提现",
                           MAIN_RED_COLOR,
                           self,
                           @selector(gotoWithdraw));
    cell.accessoryView = withdrawButton;
    
    withdrawButton.backgroundColor = [UIColor whiteColor];
    
    withdrawButton.cornerRadius = 8;
    withdrawButton.layer.borderColor = MAIN_RED_COLOR.CGColor;
    withdrawButton.layer.borderWidth = AWHairlineSize();
    
    withdrawButton.titleLabel.font = AWCustomFont(MAIN_TEXT_FONT, 15);
}

- (void)gotoWithdraw
{
    
}

- (NSArray *)fetchSettingItems
{
    return @[@{
          @"icon" : @"icon_sys_msg.png",
          @"name" : @"消息"
          },
      @{
          @"icon" : @"icon_sys_msg.png",
          @"name" : @"系统公告"
          },
      @{
          @"icon" : @"icon_ad.png",
          @"name" : @"我的广告"
          },
      @{
          @"icon" : @"icon_business.png",
          @"name" : @"商务合作"
          },
      @{
          @"icon" : @"icon_faq.png",
          @"name" : @"常见问题"
          },
      @{
          @"icon" : @"icon_feedback.png",
          @"name" : @"意见反馈"
          },
      @{
          @"icon" : @"icon_settings.png",
          @"name" : @"关于"
          }];
}

@end
