//
//  QMTaskModel.h
//  qm
//
//  Created by qm on 14-7-28.
//  Copyright (c) 2014年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DQUHeader.h"

@interface QMTaskModel : NSObject
//应用ID
@property (nonatomic, copy) NSString    *qm_AppID;

//下载应用 回传服务器，无需调用。
@property (nonatomic, copy) NSString    *qm_clickAppData;

//应用的名称
@property (nonatomic, copy) NSString    *qm_appName;

//广告语
@property (nonatomic, copy) NSString    *qm_appSummary;

//应用图标
@property (nonatomic, copy) NSString    *qm_appIcon;

//应用简介
@property (nonatomic, copy) NSString    *qm_appDescription;

//广告截图
@property (nonatomic, retain) NSArray   *qm_screenshotsArray;

//应用包名
@property (nonatomic, copy) NSString    *qm_appPackgeName;

//应用类型 (active,register)(英)
@property (nonatomic, copy) NSString    *qm_appCpaItem;

//应用类型 (激活、注册或投资)(中)
@property (nonatomic, copy) NSString    *qm_appTypeItem;

//应用的链接地址
@property(nonatomic, copy)  NSString    *qm_downLoadURL;

//应用的大小
@property (nonatomic, copy) NSString    *qm_appSize;

// 积分值
@property(nonatomic, assign) NSInteger   qm_points;

//积分单位
@property (nonatomic, copy) NSString    *qm_point_unit;

//步骤提示 (例如：打开游戏创建新角色并体验3分钟 回到本应用即可获取{积分单位})  数组形式 分几步完成
@property (nonatomic, copy) NSArray    *qm_appSteps;
@end
