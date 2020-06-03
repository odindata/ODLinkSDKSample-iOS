//
//  AppDelegate.m
//  ODLinkSDKSample
//
//  Created by nathan on 2020/5/19.
//  Copyright © 2020 odin. All rights reserved.
//

#import "AppDelegate.h"
#import "ODLHomeViewController.h"
#import <OdinShareSDK/OdinShareSDK.h>
#import <OdinLinkSDK/OdinLinkSDK.h>
#import "ODNavigationViewController.h"

@interface AppDelegate ()<ODLSDKRestoreDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    ODLHomeViewController *homeVc = [[ODLHomeViewController alloc]init];
    ODNavigationViewController *navVc = [[ODNavigationViewController alloc]initWithRootViewController:homeVc];
    self.window.rootViewController = navVc;
    [self.window makeKeyAndVisible];
    
    
    [ODLink initWitOdinKey:@"985459861c2c4e7b8f4f2c7245e56448"];
    
    [ODLink setDelegate:self];
    
    [[OdinSocialManager  defaultManager] setPlaform:OdinSocialPlatformSubTypeWechatSession appKey:@"wx8c24cb9acafaa468" appSecret:@"e83b1c1070088ca9765d6b94e14c0f35" redirectURL:nil];
    
    
    [[OdinSocialManager  defaultManager] setPlaform:OdinSocialPlatformSubTypeQQFriend appKey:@"101872615" appSecret:@"6a72ee418609c78c54d009711ec89819" redirectURL:nil];
    
    return YES;
}

- (void)ODLSDKWillRestoreScene:(ODLSDKScene *)scene Restore:(void (^)(BOOL, RestoreStyle))restoreHandler{
    restoreHandler(YES,ODLLPush);
}



- (void)ODLSDKCompleteRestore:(ODLSDKScene *)scene{
     NSLog(@"完成场景还原");
}

- (void)ODLSDKNotFoundScene:(ODLSDKScene *)scene{
    NSLog(@"未发现还原");
}


//ios9以下 URI Scheme
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
   if ([[OdinSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation]){
        return YES;
    }
    //其他代码
    return YES;
    
}

//iOS9以上 URL Scheme
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary *)options
{
   if([[OdinSocialManager  defaultManager] handleOpenURL:url]){
        return  YES;
    }
    
    //其他代码
    return YES;
    
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    NSLog(@"%@",userActivity.webpageURL);
    return YES;
}
@end
