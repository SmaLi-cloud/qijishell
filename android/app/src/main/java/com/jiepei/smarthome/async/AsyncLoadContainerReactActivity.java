package com.jiepei.smarthome.async;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.widget.Toast;

import com.jiepei.smarthome.Constants;
import com.jiepei.smarthome.utils.DispatchUtil;
import com.jiepei.smarthome.utils.PackageInfo;
import com.jiepei.smarthome.utils.TimeRecordUtil;

public class AsyncLoadContainerReactActivity extends AsyncLoadReactActivity {

    private Handler mHandler = new Handler();

    /**
     * Returns the name of the main component registered from JavaScript. This is used to schedule
     * rendering of the component.
     */
    @Override
    protected String getMainComponentName() {
        return Constants.MAIN_COMPONENT_NAME;
    }

    @Override
    protected String getDiffBundleFilePath() {
        return DispatchUtil.dispatchBundle;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
        super.onCreate(null);
        checkAndShowPageLoadingTimeCost();
    }

    private void checkAndShowPageLoadingTimeCost() {
        Log.d(Constants.TAG_LOG, "checkAndShowPageLoadingTimeCost");
        mHandler.postDelayed(() -> {
                if (TimeRecordUtil.isFinished(Constants.TAG_REACT_CONTENT_LOAD)) {
//                    if(PackageInfo.isDebuggable(this)) {
//                        Toast.makeText(this, "Time Cost:"
//                            + TimeRecordUtil.getReadableTimeCostWithUnit("RNLoad"), Toast.LENGTH_LONG).show();
//                    }
                } else {
                    checkAndShowPageLoadingTimeCost();
                }
        }, 500);
    }

    @Override
    protected void onDestroy() {
        if (null != mHandler) {
            mHandler.removeCallbacksAndMessages(null);
            mHandler = null;
        }
        super.onDestroy();
        DispatchUtil.dispatchBundle = "assets://diff.android.bundle";
    }
}
