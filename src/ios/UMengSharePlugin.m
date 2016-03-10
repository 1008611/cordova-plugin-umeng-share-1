#import <Cordova/CDV.h>
#import "UmengSharePlugin.h"

@implementation Umeng
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

        // 打开新浪微博的SSO开关
        // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
        [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

        //    //设置分享到QQ空间的应用Id，和分享url 链接
        [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
        //    //设置支持没有客户端情况下使用SSO授权
        [UMSocialQQHandler setSupportWebView:YES];
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

    - (void)share:(CDVInvokedUrlCommand*)command
    {
        [self initShare];
        CDVPluginResult* pluginResult = nil;
        NSString* echo = [command.arguments objectAtIndex:0];
        NSData* shareData = [echo dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* shareModel = [NSJSONSerialization JSONObjectWithData:shareData options:NSJSONReadingMutableLeaves error:nil];

        CDVViewController* viewController = (CDVViewController*)self.viewController;
        NSString* wechatAppId = [viewController.settings objectForKey:@"wechatappid"];
        NSString* wechatAppSecret = [viewController.settings objectForKey:@"wechatappsecret"];

        NSMutableArray* shareNames = [NSMutableArray array];
        if(wechatAppId != nil && wechatAppSecret != nil){
            [UMSocialWechatHandler setWXAppId:wechatAppId appSecret:wechatAppSecret url:[shareModel objectForKey:@"url"]];
            if([shareModel objectForKey:@"platforms"] != nil){
                NSArray* platforms = [shareModel objectForKey:@"platforms"];
                if([platforms containsObject:WECHAT_FRIEND]){
                    [shareNames addObject:UMShareToWechatSession];
                }
                if([platforms containsObject:WECHAT_TIMELINE]){
                    [shareNames addObject:UMShareToWechatTimeline];
                }
            }else{
                [shareNames addObject:UMShareToWechatSession];
                [shareNames addObject:UMShareToWechatTimeline];
            }
        }

        NSString* imageUrl = [shareModel objectForKey:@"image"];
        UIImage* image = nil;
        if(imageUrl != nil){
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];

        }
        [UMSocialSnsService presentSnsIconSheetView:viewController
                                             appKey:[viewController.settings objectForKey:@"umengappkey"]
                                          shareText:[shareModel objectForKey:@"title"]
                                         shareImage:image
                                    shareToSnsNames:shareNames
                                           delegate:self];


        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
@end