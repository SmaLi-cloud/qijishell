//
//  MMAsyncReactNativeContainerViewController.m
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/21.
//

#import "MMAsyncReactNativeContainerViewController.h"
#import "MMAsyncLoadManager.h"

@implementation MMAsyncReactNativeContainerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
//  [self.navigationItem setTitle:@"Async" ];
  NSLog(@"diffBundle in MMAsyncReactNativeContainerViewController,%@", self.diffBundle);
  [MMAsyncLoadManager.getInstance buildRootViewWithDiffBundleName:self.diffBundle withExtension:@"bundle" fromPlugin:self.isPlugin callback:^(BOOL succeed) {
    if (succeed) {
        RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:MMAsyncLoadManager.getInstance.bridge moduleName:@"smarthome" initialProperties:nil];
        rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
        self.view = rootView;
    }
  }];
}

- (void)viewDidDisappear:(BOOL)animated{
  [[MMAsyncLoadManager getInstance] prepareReactNativeEnv];
  [super viewDidDisappear:animated];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
