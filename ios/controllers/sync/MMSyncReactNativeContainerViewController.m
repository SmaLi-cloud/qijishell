//
//  MMSyncReactNativeContainerViewController.m
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/21.
//

#import "MMSyncReactNativeContainerViewController.h"

@interface MMSyncReactNativeContainerViewController ()

@end

@implementation MMSyncReactNativeContainerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
//  [self.navigationItem setTitle:@"Sync"];
  [self initReactNativeContext];
}

- (void) initReactNativeContext{
  
  NSDictionary *launchOptions = [[NSDictionary alloc] init];
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self
                                            launchOptions:launchOptions];
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"smarthome"
                                            initialProperties:nil];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  self.view = rootView;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [[NSBundle mainBundle] URLForResource:@"bundle/index.ios"
                                 withExtension:@"bundle"];
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
