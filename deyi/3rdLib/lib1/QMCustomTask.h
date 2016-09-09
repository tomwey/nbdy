//
//  QMCustomTask.h
//  qm
//
//  Created by qm on 14-7-28.
//  Copyright (c) 2014年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QMTaskModel.h"
#import "DQUHeader.h"

@protocol QumiCustomDelegate;

@interface QMCustomTask : NSObject

@property (nonatomic, assign) id<QumiCustomDelegate>  delegate;

@property (nonatomic,copy) NSString        *qmUserPointId;  //积分账户的ID用来区分不同的用户

//如果你希望在几部不同的设备中同步积分，比如你的app是游戏类的，用户注册了一个游戏账号，当这个用户换另一部手机，用该账号登陆，期望同步该账户的积分。这种情况可以设置用户pointUserId，pointUserId的优先级高于设备序列号，所以要请谨慎设置，有问题可以咨询我们商务或者技术
- (id)initwithQMPointUserID:(NSString *)qmPointUserId;

//请求数据源信息
- (void)qmRequestCustomData;

//下载某个应用
- (void)downLoadQMApp:(QMTaskModel *)QmTaskApp;

@end

@protocol QumiCustomDelegate <NSObject>
//源数据的回调 成功接收到数据
- (void)qmReceivedCustomDataWithArray:(NSMutableArray *)dataArray;

//返回失败信息
- (void)qmReceivedCustomDataFailed:(NSError *)error;

//应用点击成功通知
- (void)qmDownLoadAppSuccess:(NSString*)qmClickStatus;

//点击安装应用失败信息的回调
- (void)qmDownLoadAppFailed:(NSError *)error;

@end
