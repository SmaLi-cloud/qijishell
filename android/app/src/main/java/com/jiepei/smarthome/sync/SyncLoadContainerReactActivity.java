package com.jiepei.smarthome.sync;

import com.jiepei.smarthome.Constants;

/**
 * todo
 */
public class SyncLoadContainerReactActivity extends BaseContainerReactActivity {

    /**
     * Returns the name of the main component registered from JavaScript. This is used to schedule
     * rendering of the component.
     */

    @Override
    protected String getMainComponentName() {
        return Constants.MAIN_COMPONENT_NAME;
    }
}
