//
//  ODLink.h
//  OdinLinkSDK
//
//  Created by nathan on 2019/6/25.
//  Copyright © 2019 odin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ODLSDKRestoreDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ODLink : NSObject

+ (void)initWitOdinKey:(NSString *)odinKey;

/**
 设置场景恢复委托
 
 @param delegate 委托对象
 */
+ (void)setDelegate:(id <ODLSDKRestoreDelegate>_Nonnull)delegate;

@end

NS_ASSUME_NONNULL_END
