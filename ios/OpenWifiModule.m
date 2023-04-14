//
//  OpenWifiModule.m
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/11/8.
//

#import "OpenWifiModule.h"

@implementation OpenWifiModule

RCT_EXPORT_MODULE(OpenWifi);


RCT_EXPORT_METHOD(openNetworkSettings:(RCTResponseSenderBlock)callback) {
  NSURL *url1 = [NSURL URLWithString:@"App-prefs:root=WIFI"];
  if ([[UIApplication sharedApplication] canOpenURL:url1])
  {
    [[UIApplication sharedApplication] openURL:url1];
    callback(@[@YES,]);
  }
  else {
    callback(@[@"打开失败",]);
  }
}
@end
