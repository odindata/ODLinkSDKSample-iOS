//
//  UIViewController+ODLSDKRestore.h
//  OdinLink
//
//  Created by nathan on 2019/6/19.
//  Copyright © 2019 odin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ODLSDKScene;
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ODLSDKRestore)

/**
 设定控制器路径
 
 @return 控制器路径
 */
+ (NSString *)ODLSDKPath;

/**
 控制器初始化
 
 @param scene 场景参数
 @return 控制器对象
 */
- (instancetype)initWithOdinLinkScene:(ODLSDKScene *)scene;

@end

NS_ASSUME_NONNULL_END
