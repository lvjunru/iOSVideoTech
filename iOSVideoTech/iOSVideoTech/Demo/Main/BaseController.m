//
//  baseController.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/5/30.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "BaseController.h"
#import "CellModel.h"
#import "TableViewCell.h"


static NSString * talbeViewCellID = @"talbeViewCellID";

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:talbeViewCellID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setCellM:(CellModel *)cellM
{
    _cellM = cellM;
    self.title = cellM.Navtitle;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:talbeViewCellID];
    cell.textLabel.text = self.cellM.cellTitle;
    cell.detailTextLabel.text = self.cellM.cellDetailTitle;
    return cell;
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
