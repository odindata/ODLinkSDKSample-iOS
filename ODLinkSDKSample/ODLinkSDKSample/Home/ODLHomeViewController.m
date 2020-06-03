//
//  ODLHomeViewController.m
//  ODLinkSDKSample
//
//  Created by nathan on 2020/5/19.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODLHomeViewController.h"
#import "ODLSceneListViewController.h"
#import "ODLWakeUpViewController.h"
#import "ODLHomeCell.h"
#import "ODLHeader.h"


@interface ODLHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation ODLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ODLink";
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 23*2 - 18) / 2.0, (SCREEN_WIDTH - 23*2 - 18) / 2.0 * 377/311.0);
    flowLayout.minimumLineSpacing = 18;
    flowLayout.minimumInteritemSpacing = 18;
    flowLayout.sectionInset = UIEdgeInsetsMake(23, 23, 0, 18);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
   
    [self.collectionView registerNib:[UINib nibWithNibName:@"ODLHomeCell" bundle:nil] forCellWithReuseIdentifier:@"ReuseIdentifier"];
}

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[@{@"imgIcon":@"home_wakeup",@"type":@"一键唤醒"},@{@"imgIcon":@"home_scence",@"type":@"场景还原"}];
    }
    return _dataArray;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ODLHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReuseIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *data = self.dataArray[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:data[@"imgIcon"]];
    cell.typeLbl.text = data[@"type"];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:[ODLSceneListViewController new] animated:YES];
    }else if (indexPath.row == 0){
        [self.navigationController pushViewController:[ODLWakeUpViewController new] animated:YES];
    }
}

@end
