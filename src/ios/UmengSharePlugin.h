#import <Cordova/CDV.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"

#define UmengAppkey @"507fcab25270157b37000010"
@interface UmengSharePlugin : CDVPlugin<UMSocialUIDelegate>
 - (void)init:(CDVInvokedUrlCommand*)command;
 - (void)share:(CDVInvokedUrlCommand*)command;
@end