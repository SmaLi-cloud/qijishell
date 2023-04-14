//
//  PluginModule.m
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/21.
//

#import "PluginModule.h"
#import "MMAsyncGuideViewController.h"
#import "MMAsyncReactNativeContainerViewController.h"
#import "AppDelegate.h"
#import "ZipUtil.h"

@implementation PluginModule

RCT_EXPORT_MODULE(QIJIPlugin);

RCT_EXPORT_METHOD(loadPlugin:(NSString *)filepath
                  bundleName:(NSString *)bundleName
                  loadPluginWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  if ([self checkFileExists:filepath] == FALSE) {
    NSLog(@"插件文件不存在，%@",filepath);
    reject(RCTErrorUnspecified, nil, RCTErrorWithMessage(@"插件文件不存在"));
  }
  NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];
  if ([filepath hasSuffix:@".zip"] == YES) {
    if([ZipUtil releaseZipFilesWithUnzipFileAtPath:filepath destination:documentsDirectoryPath] == NO){
      reject(RCTErrorUnspecified, nil, RCTErrorWithMessage(@"解压插件zip文件失败"));
    }
  }
  NSString *bundleFilepath = [NSString stringWithFormat:@"%@/%@/%@.bundle", documentsDirectoryPath, bundleName, bundleName];
  if ([self checkFileExists:bundleFilepath] == NO) {
    NSLog(@"bundle文件不存在，%@",bundleFilepath);
    reject(RCTErrorUnspecified, nil, RCTErrorWithMessage(@"bundle文件不存在"));
  }
  NSString *diffBundle = [NSString stringWithFormat:@"%@/%@/%@", documentsDirectoryPath, bundleName, bundleName];
  dispatch_async(dispatch_get_main_queue(), ^{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MMAsyncGuideViewController *controller = [[MMAsyncGuideViewController alloc] init];
    controller.diffBundle = diffBundle;
    controller.isPlugin = YES;
    [app.nav pushViewController:controller animated:NO];
  });
  resolve(@"加载成功");
}

- (BOOL)checkFileExists:(NSString *)filepath {
  BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filepath];
  return fileExists;
}

RCT_EXPORT_METHOD(finish) {
  dispatch_async(dispatch_get_main_queue(), ^{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    UIViewController *vc = app.nav.viewControllers[0];
    [app.nav popToRootViewControllerAnimated:NO];
  });
}
@end

