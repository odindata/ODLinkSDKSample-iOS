//
//  ODLSceneDetailViewController.m
//  ODLinkSDKSample
//
//  Created by nathan on 2020/5/20.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODLSceneDetailViewController.h"
#import "ODLHeader.h"
#import <OdinLinkSDK/ODLSDKScene.h>
#import <OdinShareSDK/OdinShareSDK.h>
#import <OdinShareSDKUI/OdinShareSDKUI.h>
#import <OdinLinkSDK/UIViewController+ODLSDKRestore.h>

@interface ODLSceneDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) UIView *header;

@property(nonatomic,strong)ODLSDKScene *scene;

@end

@implementation ODLSceneDetailViewController


+ (NSString *)ODLSDKPath{
    return @"/demo/newsdetail";
}

- (instancetype)initWithOdinLinkScene:(ODLSDKScene *)scene{
    if (self = [super init])
    {
        self.scene = scene;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"场景还原";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NewsList" ofType:@"plist"];
    NSArray  *dataArray = [NSArray arrayWithContentsOfFile:filePath];
    
    self.tableView.tableFooterView = [UIView new];
    NSDictionary *param = self.scene.params;
    if (param) {
        NSString *page = param[@"page"];
        if ([page isEqualToString:@"detail1"]) {
            self.currentDict = dataArray.firstObject;
        }else if ([page isEqualToString:@"detail2"]){
             self.currentDict = dataArray[1];
        }
    }
    
    if (!self.currentDict) {
        return;
    }
    [self refreshHeaderWith:self.currentDict];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);

    [rightBtn setImage:[UIImage imageNamed:@"fx"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareItme = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = shareItme;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)shareItemClick:(UIButton *)sender{
    NSArray *platforms =@[
        @(OdinSocialPlatformSubTypeQQFriend),
        @(OdinSocialPlatformSubTypeQZone),
        @(OdinSocialPlatformSubTypeWechatSession),
        @(OdinSocialPlatformSubTypeWechatTimeline),
        @(OdinSocialPlatformSubTypeWechatFav)
    ];
    
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareWebpageObject *webObj = [[OdinShareWebpageObject alloc]init];
    
    NSString *shareurl = @"http://www.odinanalysis.com/.well-known/demo/link/detail.html";
    if (self.pageId == 1) {
        shareurl= @"http://www.odinanalysis.com/.well-known/demo/link/detail2.html";
    }
    
    webObj.descr = @"分享描述";
    webObj.webpageUrl = shareurl;
    webObj.title = @"分享标题";
    
    obj.shareObject = webObj;
    OdinUIShareSheetConfiguration *config=[OdinUIShareSheetConfiguration new];
    config.cancelButtonHidden = YES;
    config.style = OdinUIActionSheetStyleSimple;
    config.columnLandscapeCount = 1;
    [[OdinSocialUIManager shareInstance] showShareActionSheet:platforms shareObject:obj sheetConfiguration:config currentViewController:self CompletionHandler:^(id shareResponse, NSError *error) {
        
    }];
}

/**
 刷新tableViewHeader
 
 @param dict 字典
 */
- (void)refreshHeaderWith:(NSDictionary *)dict
{
    //清除header
    [self.header removeFromSuperview];
    self.header = nil;
    self.tableView.tableHeaderView = nil;
    
    // header
    UIView *header = [[UIView alloc] init];
    self.header = header;
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, 20, SCREEN_WIDTH - 45 * PUBLICSCALE, 0)];
    titleLabel.text = dict[@"title"];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel sizeToFit];
    
    [header addSubview:titleLabel];
    
    UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, CGRectGetMaxY(titleLabel.frame) + 10, 200, 0)];
    sourceLabel.text = dict[@"source"];
    sourceLabel.textColor = [UIColor grayColor];;
    sourceLabel.font = [UIFont systemFontOfSize:12];
    sourceLabel.textAlignment = NSTextAlignmentLeft;
    [sourceLabel sizeToFit];
    
    [header addSubview:sourceLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, CGRectGetMaxY(sourceLabel.frame), SCREEN_WIDTH - 30 * PUBLICSCALE, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    [header addSubview: line];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, CGRectGetMaxY(line.frame) + 15, SCREEN_WIDTH - 30 * PUBLICSCALE, 0)];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.font = [UIFont systemFontOfSize:17];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *dic = @{NSKernAttributeName : @1.5f};
    NSString *contentText = dict[@"content"];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:contentText attributes:dic];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 15.0;
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentText.length)];
    contentLabel.attributedText = attrStr;
    [contentLabel sizeToFit];
    
    [header addSubview:contentLabel];
    
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20 + titleLabel.frame.size.height + 15 + sourceLabel.frame.size.height + contentLabel.frame.size.height + 25);
    self.tableView.tableHeaderView = header;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
@end
