package com.jiepei.smarthome.async;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import androidx.appcompat.app.AppCompatActivity;

import com.facebook.react.bridge.ReactContext;
import com.jiepei.smarthome.R;
import com.jiepei.smarthome.utils.LoadingDialog;
import com.jiepei.smarthome.view.LoadingView;

public class AsyncLoadGuideActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_async_load_guide);
        LoadingDialog.getInstance().showLoadingDialog(this);
    }

    @Override
    protected void onStart() {
        super.onStart();
        AsyncLoadManager.getInstance().prepareReactNativeEnv(this, new AsyncLoadActivityDelegate.LoadBundleEventListener() {
            @Override
            public void onLoadFinished(ReactContext context) {
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        LoadingDialog.getInstance().closeLoadingDialog();

                        Intent intent = new Intent(context, AsyncLoadContainerReactActivity.class);

                        startActivity(intent);

                        finish();
                    }
                },200);
            }
        });
    }
}
