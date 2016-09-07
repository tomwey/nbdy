//
//  Defines.h
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

#import "AWMacros.h"

#import "AWGeometry.h"

#import "AWUITools.h"

#import "AWTextField.h"

#import "AWCustomNavBar.h"

#import "AWTableView.h"

#import "AWHairlineView.h"

#import "AWAPIManager.h"

#import "NSStringAdditions.h"

#import "AWMediator.h"

#import "AWKeyboardManager.h"

#import "AWLocationManager.h"

#import "AWButtonLoading.h"

#import "UIImageView+AFNetworking.h"

#define MAIN_TEXT_FONT      @"FZY1JW--GB1-0"
#define MAIN_DIGIT_FONT     @"CircularAirPro-Light"

#define IOS_DEFAULT_NAVBAR_BOTTOM_LINE_COLOR  AWColorFromRGB(163, 164, 165)
#define IOS_DEFAULT_CELL_SEPARATOR_LINE_COLOR AWColorFromRGB(187, 188, 193)

#define MAIN_BG_COLOR         AWColorFromRGB(239, 239, 244)
#define MAIN_RED_COLOR        AWColorFromRGB(220, 0,   27)
#define MAIN_BLACK_COLOR      AWColorFromRGB(0,   0,   0)
#define SETTINGS_GRAY_COLOR   AWColorFromRGB(161, 161, 161)
#define HOME_WIFI_CLOSE_COLOR AWColorFromRGB(151, 151, 151)

#define HOME_HAIRLINE_COLOR   MAIN_BG_COLOR//AWColorFromRGB(240, 240, 242)

#define API_V1_LOAD_EARNINGS             @"/earnings/stat"
#define API_V1_LOAD_UNREAD_MESSAGE_COUNT @"/messages/unread_count"
#define API_V1_CHECKIN                   @"/checkins"
#define API_V1_CHANNELS_LIST             @"/channels/list"
#define API_V1_FOLLOW_LIST               @"/follow_tasks/list"
#define API_V1_SHARE_LIST                @"/share_tasks/list"
#define API_V1_AD_LIST                   @"/ad_tasks/nearby"

// models
#import "Module.h"
#import "LocationInfo.h"
#import "User.h"
#import "Shipment.h"

// services
#import "ModuleService.h"
#import "LocationService.h"
#import "NetworkService.h"
#import "UserService.h"

// views
#import "LoadingView.h"
#import "SpinnerView.h"
#import "AWCustomButton.h"
#import "LocationView.h"

// controllers
#import "WebViewVC.h"

#endif /* Defines_h */
