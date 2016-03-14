#import <Cordova/CDV.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#define UmengAppkey @"56d7a6bee0f55a86c70021d8"
@interface UmengSharePlugin : CDVPlugin
 - (void)init:(CDVInvokedUrlCommand*)command;
 - (void)share:(CDVInvokedUrlCommand*)command;
@end