//
//  MMAsyncGuideViewController.m
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/21.
//

#import "MMAsyncGuideViewController.h"
#import "MMAsyncReactNativeContainerViewController.h"
#import "MMAsyncLoadManager.h"
#import "MMTimeRecordUtil.h"
#import "Masonry.h"

@implementation MMAsyncGuideViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.delegate = self;
  [self initCustomViews];
  [MMAsyncLoadManager.getInstance prepareReactNativeEnvWithCommonBundleName:@"bundle/common.ios"
                                                                  withExtension:@"bundle"];
}

- (void)viewDidAppear:(BOOL)animated {
  MMAsyncReactNativeContainerViewController *controller = [[MMAsyncReactNativeContainerViewController alloc] init];
  NSLog(@"diffBundle in MMAsyncGuideViewController,%@", self.diffBundle);
  controller.diffBundle = self.diffBundle;
  controller.isPlugin = self.isPlugin;
  [self.navigationController pushViewController:controller animated:NO];
  [[MMTimeRecordUtil getInstance] setStartTime:@"ViewAction"];
}

-(void)initCustomViews{
  UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];

  float screenWidth = [UIScreen mainScreen].bounds.size.width;//view的宽
  float screenHeight = [UIScreen mainScreen].bounds.size.height;//view的高
  float loadingWidth = activityIndicator.frame.size.width;
  float loadingHeight = activityIndicator.frame.size.height;
  float xpos = (screenWidth/2.0f) - (loadingWidth/2.0f);
  float ypos = (screenHeight/2.0f) - (loadingHeight/2.0f);

  activityIndicator.frame = CGRectMake(xpos, ypos, loadingWidth, loadingHeight);
  [self.view addSubview:activityIndicator];
  activityIndicator.color = [UIColor blueColor];
  [activityIndicator startAnimating];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];

    [self.navigationController.navigationBar setHidden:isShowHomePage];

    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

@end
