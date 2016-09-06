//
//  UserService.m
//  deyi
//
//  Created by tomwey on 9/5/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "UserService.h"
#import "User.h"
#import "NetworkService.h"

@interface UserService ()

// 用于登录,注册,获取个人信息相关
@property (nonatomic, strong) NetworkService *socialService;

// 用于修改密码，修改个人资料
@property (nonatomic, strong) NetworkService *updateService;

@property (nonatomic, strong) User *user;

@end

@implementation UserService

+ (UserService *)sharedInstance
{
    static UserService *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ( !instance ) {
            instance = [[UserService alloc] init];
        }
    });
    return instance;
}

/**
 * 获取当前登录的用户，如果存在表示登录成功
 */
- (User *)currentUser
{
    User *user = self.user ?: [self userFromDetached];
#if DEBUG
    NSLog(@"uid: %@, token: %@", user.uid, user.token);
#endif
    return user;
}

- (NSString *)currentUserAuthToken
{
    return [[self currentUser] token] ?: @"";
}

/**
 * 注册
 */
- (void)signupWithMobile:(NSString *)mobile
                password:(NSString *)password
                    code:(NSString *)code
              inviteCode:(NSString *)inviteCode
              completion:(void (^)(User *aUser, NSError *error))completion
{
    [self.socialService POST:@"/account/signup"
                      params:@{ @"mobile" : mobile ?: @"",
                                @"password" : password ?: @"",
                                @"code": code ?: @"",
                                @"invite_code": inviteCode ?: @""
                                }
                  completion:^(id result, NSError *inError)
    {
                      
        [self handleResult:result error:inError completion:completion];
    }];
}

/**
 * 登录
 */
- (void)loginWithMobile:(NSString *)mobile
               password:(NSString *)password
             completion:(void (^)(User *aUser, NSError *error))completion
{
    [self.socialService POST:@"/account/login"
                      params:@{ @"mobile": mobile ?: @"",
                                @"password": password ?: @""
                                }
                  completion:^(id result, NSError *inError)
     {
         [self handleResult:result error:inError completion:completion];
     }];
}

/**
 * 获取用户个人资料
 */
- (void)loadUserProfile:(NSString *)token
             completion:(void (^)(User *aUser, NSError *error))completion
{
    [self.socialService GET:@"/user/me"
                     params:@{
                              @"token" : token ?: @""
                              }
                 completion:^(id result, NSError *error)
    {
        [self handleResult:result error:error completion:completion];
    }];
}

- (void)logout:(void (^)(id result, NSError *error))completion
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logined.user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ( completion ) {
        completion(@{}, nil);
    }
}

- (NetworkService *)socialService
{
    if ( !_socialService ) {
        _socialService = [[NetworkService alloc] init];
    }
    return _socialService;
}

- (NetworkService *)updateService
{
    if ( !_updateService ) {
        _updateService = [[NetworkService alloc] init];
    }
    return _updateService;
}

- (void)handleResult:(id)result
               error:(NSError *)inError
          completion:(void (^)(User *aUser, NSError *error))completion
{
    if ( inError ) {
        if ( completion ) {
            completion(nil, inError);
        }
    } else {
        User *user = [[User alloc] initWithDictionary:result[@"data"]];
        [self saveUser:user];
        if ( completion ) {
            completion(user, nil);
        }
    }
}

- (void)saveUser:(User *)aUser
{
    self.user = aUser;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:aUser];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"logined.user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (User *)userFromDetached
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"logined.user"];
    if ( !obj ) {
        return nil;
    }
    
    User *aUser = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    self.user = aUser;
    return aUser;
}

@end
