//
//  ODLSceneListViewController.m
//  ODLinkSDKSample
//
//  Created by nathan on 2020/5/19.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODLSceneListViewController.h"
#import "ODLSceneDetailViewController.h"
#import "ODLNewsTableViewCell.h"
#import <OdinLinkSDK/ODLSDKScene.h>

@interface ODLSceneListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)ODLSDKScene *scene;

@end

@implementation ODLSceneListViewController

+ (NSString *)ODLSDKPath{
    return @"/demo/newslist";
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
    self.title = @"场景列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ODLNewsTableViewCell  class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ODLNewsTableViewCell  class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ODLNewsTableViewCell *cell = (ODLNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ODLNewsTableViewCell  class]) forIndexPath:indexPath];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.dict = dict;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ODLSceneDetailViewController *newsDetailCtr = [[ODLSceneDetailViewController alloc] init];
    newsDetailCtr.currentDict = self.dataArray[indexPath.row];
    newsDetailCtr.pageId = indexPath.row;
    [self.navigationController pushViewController:newsDetailCtr animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 懒加载

- (NSArray *)dataArray
{
    if (_dataArray == nil)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NewsList" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _dataArray;
}

@end
