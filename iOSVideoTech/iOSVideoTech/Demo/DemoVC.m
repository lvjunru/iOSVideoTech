//
//  DemoVC.m
//  简单的ffmpeg播放器
//
//  Created by ZhongSpace on 2017/5/17.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "DemoVC.h"
#import "collectionCell.h"
#import "cellModel.h"
#import "ChangeToH264VC.h"
#import "VideoCaptureVC.h"

@interface DemoVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak)UICollectionView * collectionView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation DemoVC

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

static NSString * const collectionCellId = @"collectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 5;
    //最小两行之间的间距
    layout.minimumLineSpacing = 5;
    
     UICollectionView *  collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor  = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([collectionCell class]) bundle:nil] forCellWithReuseIdentifier:collectionCellId];
    collectionView.dataSource = self;
    collectionView.delegate  = self;
    
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    
    [self setupData];
}

-(void)setupData
{
    cellModel * getH264Model = [[cellModel alloc] initWithTitle:@"FFMpeg视频转H264"];
    
    cellModel * captureModel = [[cellModel alloc] initWithTitle:@"捕获iPhone视频流&解码保存"];
    
    [self.dataArray addObject:getH264Model];
    [self.dataArray addObject:captureModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    cellModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(115, 100);
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    cellModel * model = self.dataArray[indexPath.row];
    
    if ([model.title isEqualToString:@"FFMpeg视频转H264"]) {
        ChangeToH264VC * change264VC = [[ChangeToH264VC alloc] init];
        change264VC.cellM = model;
        [self.navigationController pushViewController:change264VC animated:YES];
    }
    
    if ([model.title isEqualToString:@"捕获iPhone视频流&解码保存"]) {
        VideoCaptureVC * captureVC = [[VideoCaptureVC alloc] init];
        captureVC.cellM = model;
        [self.navigationController pushViewController:captureVC animated:YES];
    }
    
}

@end
