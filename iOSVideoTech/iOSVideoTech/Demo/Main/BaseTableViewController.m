//
//  baseController.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/5/30.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CellModel.h"
#import "TableViewCell.h"
#import "iOSVideoTechConst.h"

static NSString * talbeViewCellID = @"talbeViewCellID";

@interface BaseTableViewController ()



@end

@implementation BaseTableViewController


-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:talbeViewCellID];
    
    //设置返回按钮的样式
    UIButton * leftButton  = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50,50)];
    [leftButton setTitle:@"BACK" forState:UIControlStateNormal];
    [leftButton setTitleColor:globalTextColor forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:talbeViewCellID];
    CellModel * cellM = self.dataArray[indexPath.row];
    cell.cellM = cellM;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
