#import <Cordova/CDV.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"

#define UmengAppkey @"507fcab25270157b37000010"
#define WXAppId @"wxdafdsafdsfsaf"
#define WXAppSecret @"507fcab25270157b37000010"
#define QQAppId @""
#define QQAppKey @""
#define SinaSSOAppKey @""
#define SinaSSOAppSecret @""

@interface UmengSharePlugin : CDVPlugin<UMSocialUIDelegate>
 - (void)init:(CDVInvokedUrlCommand*)command;
 - (void)share:(CDVInvokedUrlCommand*)command;
@end