package com.jiepei.smarthome;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import androidx.appcompat.app.AppCompatActivity;

import com.facebook.react.bridge.ReactContext;
import com.jiepei.smarthome.async.AsyncLoadActivityDelegate;
import com.jiepei.smarthome.async.AsyncLoadContainerReactActivity;
import com.jiepei.smarthome.async.AsyncLoadManager;

public class SplashActivity extends AppCompatActivity {
    @Override
    protected void onStart() {
        super.onStart();
        AsyncLoadManager.getInstance().prepareReactNativeEnv(this, new AsyncLoadActivityDelegate.LoadBundleEventListener() {
            @Override
            public void onLoadFinished(ReactContext context) {
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        Intent intent = new Intent(context, AsyncLoadContainerReactActivity.class);
//                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                        finish();
                    }
                }, 1500);
            }
        });
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.splash_activity);
        // 避免从桌面启动程序后，会重新实例化入口类的activity
        if (!this.isTaskRoot()) {
            Intent intent = getIntent();
            if (intent != null) {
                String action = intent.getAction();
                if (intent.hasCategory(Intent.CATEGORY_LAUNCHER) && Intent.ACTION_MAIN.equals(action)) {
                    finish();
                    return;
                }
            }
        }
    }
}