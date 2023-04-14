//
//  MMAsyncLoadManager.m
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/21.
//

#import "MMAsyncLoadManager.h"
#import "RCTBridge.h"
#import <React/RCTBridge+Private.h>

static MMAsyncLoadManager *instance;

@implementation MMAsyncLoadManager

+ (MMAsyncLoadManager *) getInstance{
  @synchronized(self) {
    if (!instance) {
      instance = [[self alloc] init];
    }
  }
  return instance;
}

-(instancetype) init{
  self.commonBundleExtension = @"bundle";
  self.commonBundleName = @"common.ios";
  // success listener
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(onJSDidLoad:)
   name:RCTJavaScriptDidLoadNotification
   object:nil];
  // error listener
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(onJSLoadError:)
   name:RCTJavaScriptDidFailToLoadNotification
   object:nil];
  self.pendingQueue = [[NSMutableArray alloc] initWithCapacity:1];
  return self;
}

-(void) prepareReactNativeEnv{
  NSDictionary *launchOptions = [[NSDictionary alloc] init];
  self.bridge = [[RCTBridge alloc] initWithDelegate:self
                                      launchOptions:launchOptions];
  self.commonStatus = RNBundleLoadStatus_Loading;
}

-(void) prepareReactNativeEnvWithCommonBundleName:(NSString*) fileName withExtension:(NSString*) extension{
  self.commonBundleName = fileName;
  self.commonBundleExtension = extension;
  [self prepareReactNativeEnv]; 
}

-(void) buildRootViewWithDiffBundleName:(NSString*) fileName withExtension:(NSString*) extension fromPlugin:(BOOL) isPlugin callback:(RNBusinessLoadCallback)callback {
  NSError *error = nil;
  NSData * diffData = nil;
  if (!isPlugin) {
    NSURL *diffFileURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:extension];
    diffData = [NSData dataWithContentsOfURL:diffFileURL options:NSDataReadingMappedIfSafe error:&error];
  }
  else {
    NSString *filePath = [NSString stringWithFormat:@"%@.%@", fileName, extension];
    diffData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
  }
  
  if (error == nil) { // load source success
    RNBusinessLoadCallback blk = ^(BOOL successed) {
      if (successed) {
        [self.bridge.batchedBridge  executeSourceCode:diffData sync:NO];
        callback(YES);
      } else {
        callback(successed);
      }
    };

    if (self.commonStatus == RNBundleLoadedStatus_Successed) {
      blk(YES);
    } else { // wait for base bundle load success
      [self.pendingQueue addObject:blk];
    }
  } else {
    callback(NO);
  }
}

#pragma mask - js listener
- (void)onJSDidLoad:(NSNotification *)notification {
  // base lib load success!
  NSLog(@"base bundle load success!");
  [self _baseBundleLoad:nil];
}

- (void)onJSLoadError:(NSNotification *)notification {
  // base lib load failed!
  NSLog(@"base bundle load faild!");
  [self _baseBundleLoad: [NSError new]];
}

- (void)_processPendingQueue {

  if (self.commonStatus == RNBundleLoadedStatus_Successed) {
    for (RNBusinessLoadCallback blk in self.pendingQueue) {
      blk(YES);
    }
  } else if (self.commonStatus == RNBundleLoadStatus_Failed) { // in case load failed
    for (RNBusinessLoadCallback blk in self.pendingQueue) {
      blk(NO);
    }
  }

  [self.pendingQueue removeAllObjects]; // clean up
}

- (void)_baseBundleLoad:(NSError *)error {

  static int retry = 0;
  if (error && retry > 0) {
    retry--;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
      [self.bridge reload];
    });
  } else {
    self.commonStatus =
    error ? RNBundleLoadStatus_Failed : RNBundleLoadedStatus_Successed;
    [self _processPendingQueue];
  }
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return  [[NSBundle mainBundle] URLForResource:self.commonBundleName
                                  withExtension:self.commonBundleExtension];
}

@end
