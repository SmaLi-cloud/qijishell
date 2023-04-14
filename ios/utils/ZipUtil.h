//
//  ZipUtil.h
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/22.
//

#import <Foundation/Foundation.h>
#import <React/RCTLog.h>
#import <SSZipArchive.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZipUtil : NSObject

+ (BOOL)releaseZipFilesWithUnzipFileAtPath:(NSString *)zipPath destination:(NSString *)unzipPath;

@end

NS_ASSUME_NONNULL_END
