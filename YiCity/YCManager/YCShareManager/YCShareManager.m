//
//  YCShareManager.m
//  Test
//
//  Created by szhang on 27/11/2015.
//  Copyright © 2015 hezi. All rights reserved.
//

#import "YCShareManager.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import "QQShareManager.h"
#import "WXShareManager.h"

@implementation YCShareManager
static YCShareManager *singleton = nil ;
+(YCShareManager *)sharedManager
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        singleton = [[YCShareManager alloc]init];
    });
    return singleton ;
}

+(void)registerApp
{
    [WXApi registerApp:WXAPPID] ;
    [WeiboSDK registerApp:WEIBOAPPID] ;
    [[QQShareManager sharedManager] registerApp:QQAPPID];
}

+(BOOL)sendReq:(NSObject *)req
{
    BOOL ret = NO ;
    if ([req isKindOfClass:[QQBaseReq class]]) {
        QQBaseReq *qqReq = (QQBaseReq *)req ;
       ret =  [[QQShareManager sharedManager] sendReq:qqReq scene:QZONE];
    }else if ([req isKindOfClass:[SendMessageToWXReq class]])
    {
        SendMessageToWXReq *wxReq = (SendMessageToWXReq *)req ;
        ret = [[WXShareManager sharedManager] sendReq:wxReq] ;
    }
    return ret ;
}
@end
