//
//  ODLWakeUpViewController.m
//  ODLinkSDKSample
//
//  Created by nathan on 2020/5/19.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODLWakeUpViewController.h"
#import <OdinShareSDK/OdinShareSDK.h>
#import <OdinShareSDKUI/OdinShareSDKUI.h>

@interface ODLWakeUpViewController ()
@property (weak, nonatomic) IBOutlet UIButton *wakeupBtn;

@end

@implementation ODLWakeUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一键唤醒";
    self.wakeupBtn.layer.cornerRadius = 4;
    self.wakeupBtn.layer.masksToBounds = YES;
}

- (IBAction)wakeupAction:(id)sender {
    NSArray *platforms =@[
        @(OdinSocialPlatformSubTypeQQFriend),
        @(OdinSocialPlatformSubTypeQZone),
        @(OdinSocialPlatformSubTypeWechatSession),
        @(OdinSocialPlatformSubTypeWechatTimeline),
        @(OdinSocialPlatformSubTypeWechatFav)
    ];

        OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
        OdinShareWebpageObject *webObj = [[OdinShareWebpageObject alloc]init];

        webObj.descr = @"分享描述";
    webObj.webpageUrl = @"http://www.odinanalysis.com/.well-known/demo/link/index.html";
        webObj.title = @"分享标题";
        
        obj.shareObject = webObj;
        OdinUIShareSheetConfiguration *config=[OdinUIShareSheetConfiguration new];
        config.cancelButtonHidden = YES;
        config.style = OdinUIActionSheetStyleSimple;
        config.columnLandscapeCount = 1;
        [[OdinSocialUIManager shareInstance] showShareActionSheet:platforms shareObject:obj sheetConfiguration:config currentViewController:self CompletionHandler:^(id shareResponse, NSError *error) {
           
        }];
}


@end
