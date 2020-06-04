# ODLinkSDKSample-iOS
奥丁LinkSDK示例demo
# OdinLink集成
一键唤醒APP,跳转到指定界面
### CocoaPods
[CocoaPods](http://cocoapods.org) 是向项目添加OdinLink的推荐方法。
1. 将OdinAnalysis的pod条目添加到您的Podfile文件中

###### 集成
    pod 'OdinLink'
   
2. 通过运行“pod Install”安装

3. 在AppDelegate中导入头文件：```#import <OdinLinkSDK/ODLink.h>```
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [ODLink initWitOdinKey:@"1442AABEB4E2477892982BBC9D09BD61"];
   
    return YES;
}
```

4.在需要恢复的控制器中实现UIViewController+ODLSDKRestore的两个方法

```
@interface ResotreAViewController ()
@property(nonatomic,strong)ODLSDKScene *scene;
@end

+ (NSString *)ODLSDKPath{
    return @"/demo/a";
}

- (instancetype)initWithOdinLinkScene:(ODLSDKScene *)scene{
    if (self = [super init])
    {
        self.scene = scene;
    }
    return self;
}
```

第一个是实现标识控制器路径的方法 
第二个是实现带有场景参数的初始化方法，并根据场景参数还原该控制器


5.如果需要监听场景还原可以遵守：ODLSDKRestoreDelegate代理并实现对应的代理方法

``` 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [ODLink initWitOdinKey:@"1442AABEB4E2477892982BBC9D09BD61"];
    [ODLink setDelegate:self];
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
```
