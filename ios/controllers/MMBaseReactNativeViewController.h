//
//  MMBaseReactNativeViewController.h
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/21.
//

#import <UIKit/UIKit.h>
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "CRToast.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMBaseReactNativeViewController : UIViewController <UINavigationControllerDelegate>

- (void)showToast:(NSString*) msg;

@end

NS_ASSUME_NONNULL_END
