package com.jiepei.smarthome;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.Callback;
import com.jiepei.smarthome.async.AsyncLoadContainerReactActivity;
import com.jiepei.smarthome.async.AsyncLoadGuideActivity;
import com.jiepei.smarthome.utils.DispatchUtil;
import com.jiepei.smarthome.utils.ZipUtils;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import androidx.core.content.FileProvider;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Map;
import java.util.HashMap;

public class PluginModule extends ReactContextBaseJavaModule {
    private ReactApplicationContext context;
    public PluginModule(ReactApplicationContext reactContext) {
        super(reactContext);
        context = reactContext;
    }

    @Override
    public String getName() {
        return "QIJIPlugin";
    }

    @ReactMethod
    /**
     * 加载插件
     */
    public void loadPlugin(final String filepath, final String bundleName, Promise p) {
        try {
            File f = new File(filepath);
            if (!f.exists()) {
                throw new FileNotFoundException();
            }
            if(filepath.endsWith(".zip")) {
                boolean result = ZipUtils.unzip(filepath, context.getFilesDir().getAbsolutePath());
                if (!result) {
                    throw new Exception("解压缩失败");
                }
                f.delete();
            }
            String bundleFilepath = context.getFilesDir().getAbsolutePath() + "/" + bundleName+"/" + bundleName+".bundle";
            File bundleFile = new File(bundleFilepath);
            if (!bundleFile.exists()) {
                throw new FileNotFoundException();
            }
            DispatchUtil.dispatchBundle = bundleFilepath;
            Intent starter = new Intent(context, AsyncLoadGuideActivity.class);
            starter.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(starter);
            p.resolve("加载成功");
        } catch (Exception e) {
            p.reject(e);
        }
    }

    @ReactMethod
    public void finish(){
        getCurrentActivity().finish();
    }
}