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

@interface FFMpegCatalogueVC ()

@end

@implementation FFMpegCatalogueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CellModel * VideoInfoM = [[CellModel alloc] init];
    VideoInfoM.Navtitle = @"FFMpeg获取视频信息";
    VideoInfoM.cellTitle = @"FFMpeg获取视频信息";
    
    CellModel * ChangeToH264M = [[CellModel alloc] init];
    
    ChangeToH264M.Navtitle = @"FFMpeg读取视频H264裸流";
    ChangeToH264M.cellTitle = @"FFMpeg读取视频H264裸流";
    
    [self.dataArray addObject:VideoInfoM];
    
    [self.dataArray addObject:ChangeToH264M];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CellModel * model = self.dataArray[indexPath.row];
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
