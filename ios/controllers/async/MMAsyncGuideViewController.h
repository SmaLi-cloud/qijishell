//
//  MMAsyncGuideViewController.h
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/21.
//

#import <UIKit/UIKit.h>
#import <React/RCTBridgeDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMAsyncGuideViewController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, strong) NSString *diffBundle;
@property (nonatomic, assign) BOOL isPlugin;

@end

NS_ASSUME_NONNULL_END
