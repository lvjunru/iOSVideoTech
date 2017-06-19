//
//  NativeCatalogueVC.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/6/19.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "NativeCatalogueVC.h"
#import "CellModel.h"
#import "VideoCaptureVC.h"
@interface NativeCatalogueVC ()

@end

@implementation NativeCatalogueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CellModel * VideoInfoM = [[CellModel alloc] init];
    VideoInfoM.Navtitle = @"VideoToolBox的使用";
    VideoInfoM.cellTitle = @"VideoToolBox的使用";
    
    
    [self.dataArray addObject:VideoInfoM];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CellModel * model = self.dataArray[indexPath.row];
    if ([model.Navtitle isEqualToString:@"VideoToolBox的使用"]) {
        VideoCaptureVC * videoCapture = [[VideoCaptureVC alloc] init];
        videoCapture.title = @"VideoToolBox的使用";
        [self.navigationController pushViewController:videoCapture animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
