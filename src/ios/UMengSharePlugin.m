#import <Cordova/CDV.h>
#import "UmengSharePlugin.h"

@implementation UmengSharePlugin
    - (void)init:(CDVInvokedUrlCommand*)command
    {
        //设置友盟社会化组件appkey
        [UMSocialData setAppKey:UmengAppkey];

        //打开调试log的开关
        [UMSocialData openLog:YES];

        //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
        [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];

        //设置微信AppId，设置分享url，默认使用友盟的网址
        [UMSocialWechatHandler setWXAppId:@"wx0dd217e4af73378d" appSecret:@"da4150f467abd29d29008d64a27b2e3b" url:@"https://zhoujin.com"];
    }

    /**
        这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
     */
    - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
    {
        return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    }

    /**
        这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
     */
    - (void)applicationDidBecomeActive:(UIApplication *)application
    {
        [UMSocialSnsService  applicationDidBecomeActive];
    }
@end