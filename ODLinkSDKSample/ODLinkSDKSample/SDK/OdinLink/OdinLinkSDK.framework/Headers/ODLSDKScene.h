//
//  ODLSDKScene.h
//  OdinLink
//
//  Created by nathan on 2019/6/20.
//  Copyright © 2019 odin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODLSDKScene : NSObject

/**
路径
*/
@property (nonatomic, copy, nullable) NSString *path;

/**
 来源标识
 */
@property (nonatomic, copy, nullable) NSString *source;

/**
 自定义参数
 */
@property (nonatomic, strong, nullable)  NSDictionary *params;


/**
 打开的原始链接
 */
@property (nonatomic, copy, nullable) NSString *rawURL;

/**
 场景信息初始化
 
 @param path 路径,应传入需要恢复的控制器所设定的路径,即控制器在实现UIViewController+ODLSDKRestore里面的+[ODLSDKPath]时所返回的值。
 @param source 来源标识
 @param params 自定义参数,可传入自定义键值对
 @return 场景对象
 */
- (instancetype _Nullable )initWithODLSDKPath:(nullable NSString *)path source:(nullable NSString *)source params:(nullable NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
