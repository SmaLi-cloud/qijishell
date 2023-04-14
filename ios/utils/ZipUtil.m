//
//  ZipUtil.m
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/22.
//

#import "ZipUtil.h"

@implementation ZipUtil

+ (BOOL)releaseZipFilesWithUnzipFileAtPath:(NSString *)zipPath destination:(NSString *)unzipPath {
  NSError *error;
  if ([SSZipArchive unzipFileAtPath:zipPath toDestination:unzipPath overwrite:YES password:nil error:&error delegate:nil]) {
    RCTLogInfo(@"zipPath = %@,unzipPath = %@", zipPath, unzipPath);
    return YES;
  }else {
    RCTLogInfo(@"%@",error);
    return NO;
  }
}

@end
