# cordova-plugin-umeng-share
cordova友盟分享插件

目前使用的是umeng分享的5.0.2版本，支持分享到微信，微博和qq。目前个平台的key使用的是umeng的测试key。后续会增加修改的地方

#安装
cordova plugin add https://github.com/freeocs/cordova-plugin-umeng-share.git --variable API_KEY=YOUR_UMENG_APP_KEY 

#ios编译环境准备
1. 添加SDK后需要手动添加系统库SystemConfiguration.framework 
2. 若你的工程设置了all_load，需要添加手机QQ SDK需要的系统framework:Security.framework,libiconv.dylib,CoreGraphics.framework，libsqlite3.dylib，CoreTelephony.framework,ImageIO.framework,libstdc++
.dylib,libz.dylib。

#使用
##初始化
在页面js开始能执行的地方
```
UMengSharePlugin.init(function () {
	console.log('UMengShare init success');
});
```

##分享
```
UMengSharePlugin.share('内容','标题','http://www.baidu.com',’图片地址’, function(){
    console.log('分享成功');
}, function(){
    console.log('分享失败');
});

```