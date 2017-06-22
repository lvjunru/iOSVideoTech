//
//  FFMpegCatalogueVC.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/6/19.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "FFMpegCatalogueVC.h"
#import "CellModel.h"
#import "ChangeToH264VC.h"
#import "VideoInfoVC.h"

@interface FFMpegCatalogueVC ()

@end

@implementation FFMpegCatalogueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CellModel * videoInfoM = [[CellModel alloc] init];
    videoInfoM.Navtitle = @"FFMpeg获取视频信息";
    videoInfoM.cellTitle = @"FFMpeg获取视频信息";
    
    CellModel * changeToH264M = [[CellModel alloc] init];
    changeToH264M.Navtitle = @"FFMpeg读取视频H264裸流";
    changeToH264M.cellTitle = @"FFMpeg读取视频H264裸流";
    
    
    
    CellModel * videoPlay = [[CellModel alloc] init];
    videoPlay.Navtitle = @"FFMpeg获取视频流并且播放";
    videoPlay.cellTitle = @"FFMpeg获取视频流并且播放";
    
    
    CellModel * audioStream = [[CellModel alloc] init];
    audioStream.Navtitle = @"FFMpeg获取音频流并且播放";
    audioStream.cellTitle = @"FFMpeg获取音频流并且播放";
    
    
    CellModel * subTitleStream = [[CellModel alloc] init];
    subTitleStream.Navtitle = @"FFMpeg获取字幕";
    subTitleStream.cellTitle = @"FFMpeg获取字幕";
    
    
    
    [self.dataArray addObject:videoInfoM];
    [self.dataArray addObject:changeToH264M];
    [self.dataArray addObject:videoPlay];
    [self.dataArray addObject:audioStream];
    [self.dataArray addObject:subTitleStream];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CellModel * model = self.dataArray[indexPath.row];
    
    if ([model.Navtitle isEqualToString:@"FFMpeg获取视频信息"]) {
        VideoInfoVC * videoInfoVC = [[VideoInfoVC alloc] init];
        videoInfoVC.title = @"FFMpeg获取视频信息";
        [self.navigationController pushViewController:videoInfoVC animated:YES];
    }
    
    if ([model.Navtitle isEqualToString:@"FFMpeg读取视频H264裸流"]) {
        ChangeToH264VC * change264VC = [[ChangeToH264VC alloc] init];
        change264VC.title = @"FFMpeg读取视频H264裸流";
        [self.navigationController pushViewController:change264VC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
