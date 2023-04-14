//
//  RCTBridge.h
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/21.
//

#import <Foundation/Foundation.h>
 
@interface RCTBridge (RnLoadJS)
 
 - (void)executeSourceCode:(NSData *)sourceCode sync:(BOOL)sync;
 
@end
