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
    private final static String WXAppId="wx12342956d1cab4f9";
    private final static String WXAppSecret="a5ae111de7d9ea137e88a5e02c07c94d";
    private final static String QQAppId="";
    private final static String QQAppKey="";
    private final static String SinaSSOAppKey="";
    private final static String SinaSSOAppSecret="";
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
        PlatformConfig.setWeixin(WXAppId,WXAppSecret);
        PlatformConfig.setQQZone(QQAppId,QQAppKey);
        PlatformConfig.setSinaWeibo(SinaSSOAppKey,SinaSSOAppSecret);
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
                        SHARE_MEDIA.QQ,
                        SHARE_MEDIA.SINA
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