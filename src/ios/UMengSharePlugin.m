#import <Cordova/CDV.h>
#import "UmengSharePlugin.h"

@implementation UmengSharePlugin
- (void)init:(CDVInvokedUrlCommand*)command
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    
    //打开调试log的开关
    [UMSocialData openLog:NO];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
}
- (void)share:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* text = [command.arguments objectAtIndex:0];
    NSString* title = [command.arguments objectAtIndex:1];
    NSString* url = [command.arguments objectAtIndex:2];
    //NSString* imageUrl = [command.arguments objectAtIndex:3];
    //NSLog(@"imageUrl: %@",imageUrl);
    
    //NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),@"test"];
    //UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
    
    [UMSocialData defaultData].extConfig.title = title;
    
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wx0dd217e4af73378d"
                            appSecret:@"da4150f467abd29d29008d64a27b2e3b"
                                  url:url];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2479177297"
                                              secret:@"2bbc99552e243de228f017b4ecf5d62f"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //设置分享到QQ/Qzone的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"1105155569"
                               appKey:@"aYZIXMhRhZyvTXy5"
                                  url:@"http://www.umeng.com/social"];
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友等平台需要参考各自的集成方法
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:self.viewController
                                         appKey:UmengAppkey
                                      shareText:text
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                       delegate:nil];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
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