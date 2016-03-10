package com.zoylus.cordova.umeng.share;

import com.umeng.socialize.PlatformConfig;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.bean.SHARE_MEDIA;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

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
        PlatformConfig.setWeixin("wx967daebe835fbeac","5bb696d9ccd75a38c8a0bfe0675559b3");
        //豆瓣RENREN平台目前只能在服务器端配置
        //新浪微博
        PlatformConfig.setSinaWeibo("3921700954","04b48b094faeb16683c32669824ebdad");
        //QQ空间 appkey appsecret
        PlatformConfig.setQQZone("100424468","c7394704798a158208a74ab60104f0ba");
        callbackContext.success();
    }

    private void share(final JSONArray args,final CallbackContext callbackContext){
        cordova.getActivity().runOnUiThread(new Runnable(){
            @Override
            public void run(){
                String text=args.optString(0);
                String title=args.optString(1);
                String url=args.optString(2);
                final SHARE_MEDIA[] displaylist=new SHARE_MEDIA[]{SHARE_MEDIA.WEIXIN,SHARE_MEDIA.WEIXIN_CIRCLE,SHARE_MEDIA.SINA,SHARE_MEDIA.QQ,SHARE_MEDIA.QZONE};
                new ShareAction(cordova.getActivity()).setDisplayList(displaylist).withText(text).withTitle(title).withTargetUrl(url).open();
                callbackContext.success();
            }
        });
    }
}