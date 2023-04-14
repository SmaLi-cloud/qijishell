//
//  MMTimeRecordUtil.h
//  qiji_app_shell
//
//  Created by 李苗利 on 2021/10/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMTimeRecordUtil : NSObject

@property (nonatomic, strong) NSMutableDictionary *recordDic;

+ (MMTimeRecordUtil *)getInstance;

- (void)setStartTime:(NSString*) tag;
- (void)setEndTime:(NSString*) tag;
- (void)printTimeInfo:(NSString*) tag;
- (long)getTimeCost:(NSString*) tag;
- (NSString*)getReadableTimeCostWithUnit:(NSString*) tag;
- (BOOL)isFinished:(NSString*) tag;

@end

NS_ASSUME_NONNULL_END
