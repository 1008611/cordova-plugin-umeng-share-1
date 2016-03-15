package com.zoylus.cordova.umeng.share;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

import com.umeng.socialize.PlatformConfig;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.utils.Log;

/**
 * Created by cdm on 1/5/16.
 */
public class UMengSharePlugin extends CordovaPlugin{
    @Override
    public boolean execute(String action,JSONArray args,CallbackContext callbackContext) throws JSONException{
        if(action.equals("init")){
            init(args,callbackContext);
        }else if(action.equals("share")){
            share(args,callbackContext);
        }
        return false;
    }

    private void init(JSONArray args,CallbackContext callbackContext){
        //微信    wx12342956d1cab4f9,a5ae111de7d9ea137e88a5e02c07c94d
        PlatformConfig.setWeixin("wx0dd217e4af73378d","da4150f467abd29d29008d64a27b2e3b");
        //豆瓣RENREN平台目前只能在服务器端配置
        //新浪微博  AppKey    2479177297         AppSecret      2bbc99552e243de228f017b4ecf5d62f
        PlatformConfig.setSinaWeibo("2479177297","2bbc99552e243de228f017b4ecf5d62f");
        //新浪微博 appkey appsecret  1105151789 g3pSLkpIHAVLnsDp
        PlatformConfig.setQQZone("1105151789","g3pSLkpIHAVLnsDp");
        callbackContext.success();
    }

    private void share(final JSONArray args,final CallbackContext callbackContext){
        cordova.getActivity().runOnUiThread(new Runnable(){
            @Override
            public void run(){
                String text=args.optString(0);
                String title=args.optString(1);
                String url=args.optString(2);
                String imgUrl=args.optString(3);
                //
                final SHARE_MEDIA[] displaylist=new SHARE_MEDIA[]{
                        SHARE_MEDIA.WEIXIN,
                        SHARE_MEDIA.WEIXIN_CIRCLE,
                        SHARE_MEDIA.SINA,
                        SHARE_MEDIA.QQ,
                        SHARE_MEDIA.QZONE
                };
                ShareAction action =  new ShareAction(cordova.getActivity()) ;
                action.setDisplayList(displaylist) ;
                action.getShareContent().mText = text ;
                action.getShareContent().mTitle = title ;
                action.getShareContent().mTargetUrl = url ;
                action.getShareContent().mMedia = new UMImage(cordova.getActivity(),  imgUrl ) ;
                action.open();
                callbackContext.success();
            }
        });
    }
}