/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"
#import "MMAsyncGuideViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.backgroundColor = [UIColor whiteColor];
  
  MMAsyncGuideViewController *controller = [[MMAsyncGuideViewController alloc] init];
  controller.diffBundle = @"bundle/diff.ios";
  controller.isPlugin = NO;
  _nav = [[UINavigationController alloc] initWithRootViewController:controller];
  self.window.rootViewController = _nav;
  [self.window makeKeyAndVisible];
  return YES;
}

@end

