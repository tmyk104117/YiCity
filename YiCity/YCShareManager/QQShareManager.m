//
//  QQShareManager.m
//  Test
//
//  Created by szhang on 27/11/2015.
//  Copyright © 2015 hezi. All rights reserved.
//

#import "QQShareManager.h"


@interface QQShareManager()<TencentSessionDelegate>
@property (nonatomic,strong)TencentOAuth *tencentOAuth ;
@end

@implementation QQShareManager
static QQShareManager *singleton = nil ;
+(QQShareManager *)sharedManager
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        singleton = [[QQShareManager alloc]init];
    });
    return singleton ;
}

-(id)init
{
    self = [super init] ;
    if (self) {
        
    }
    
    return self ;
}

-(void)registerApp:(NSString *)appID
{
    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:appID andDelegate:self] ;
}

-(BOOL)sendReq:(QQBaseReq *)req
{
    if (_tencentOAuth) {
        QQApiSendResultCode code = [QQApiInterface SendReqToQZone:req] ;
        if (code == EQQAPISENDSUCESS) {
            return YES ;
        }else
        {
            return NO ;
        }
    }else
    {
        return  NO ;
    }
}

+(QQBaseReq *)QQNewsReq:(NSString *)htmlUrl htmlTitle:(NSString *)htmlTitle htmlDescription:(NSString *)htmlDescription previewImageUrl:(NSString *)previewImageUrl
{
    if (htmlUrl == nil) {
        return nil ;
    }
    NSURL *htmlURL = [NSURL URLWithString:htmlUrl] ;
    NSURL *preViewImageURL = [NSURL URLWithString:previewImageUrl] ;
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:htmlURL title:htmlTitle description:htmlDescription previewImageURL:preViewImageURL];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj ] ;
    return req ;
}

@end