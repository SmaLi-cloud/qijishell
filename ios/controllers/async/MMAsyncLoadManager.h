//
//  MMAsyncLoadManager.h
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/21.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>
#import <React/RCTRootView.h>
#import <React/RCTBridgeDelegate.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    RNBundleLoadStatus_Init = 0,
    RNBundleLoadStatus_Loading = 1,
    RNBundleLoadedStatus_Successed = 2,
    RNBundleLoadStatus_Failed = 3
} RNBundleLoadStatus;

typedef void(^RNBusinessLoadCallback)(BOOL succeed);

@interface MMAsyncLoadManager : NSObject<RCTBridgeDelegate>

@property (nonatomic, strong) RCTBridge *bridge;
@property (nonatomic, strong) NSString *commonBundleName;
@property (nonatomic, strong) NSString *commonBundleExtension;
@property(nonatomic,assign) RNBundleLoadStatus commonStatus;
@property(nonatomic, strong) NSMutableArray *pendingQueue;

+ (MMAsyncLoadManager *)getInstance;

-(void) prepareReactNativeEnv;

-(void) prepareReactNativeEnvWithCommonBundleName:(NSString*) fileName withExtension:(NSString*) extension;

-(void) buildRootViewWithDiffBundleName:(NSString*) fileName withExtension:(NSString*) extension fromPlugin:(BOOL) isPlugin callback:(RNBusinessLoadCallback) callback;

@end

NS_ASSUME_NONNULL_END
