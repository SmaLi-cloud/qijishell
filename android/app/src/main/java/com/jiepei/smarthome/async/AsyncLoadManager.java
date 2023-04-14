package com.jiepei.smarthome.async;

import android.app.Activity;
import android.util.Log;

import com.facebook.react.ReactApplication;
import com.jiepei.smarthome.Constants;

public class AsyncLoadManager implements IAsyncLoadManager {

    private static volatile AsyncLoadManager sInstance;

    private AsyncLoadActivityDelegate mDelegate;

    public static AsyncLoadManager getInstance() {
        if (null == sInstance) {
            synchronized (AsyncLoadManager.class) {
                if (null == sInstance) {
                    sInstance = new AsyncLoadManager();
                }
            }
        }
        return sInstance;
    }


    @Override
    public void prepareReactNativeEnv(Activity activity, AsyncLoadActivityDelegate.LoadBundleEventListener loadBundleEventListener) {
        if (null == mDelegate || !mDelegate.isAvailable) {
            Log.d(Constants.TAG_LOG, "prepareReactNativeEnv create new mDelegate");
            mDelegate = new AsyncLoadActivityDelegate(((ReactApplication) activity.getApplication()).getReactNativeHost());
            if(loadBundleEventListener != null) {
                mDelegate.AddLoadBundleEventListener(loadBundleEventListener);
            }
            mDelegate.initReactContextInBackground();
        }
    }

    @Override
    public synchronized AsyncLoadActivityDelegate getAvailableDelegate() {
        return mDelegate;
    }

}
