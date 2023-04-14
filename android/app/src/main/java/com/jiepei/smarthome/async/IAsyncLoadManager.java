package com.jiepei.smarthome.async;

import android.app.Activity;

public interface IAsyncLoadManager {

    void prepareReactNativeEnv(Activity activity, AsyncLoadActivityDelegate.LoadBundleEventListener loadBundleEventListener);

    AsyncLoadActivityDelegate getAvailableDelegate();
}
