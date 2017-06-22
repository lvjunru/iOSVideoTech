//
//  VideoInfoView.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/6/21.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "VideoInfoView.h"

@interface VideoInfoView()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation VideoInfoView

+(instancetype)videoInfoView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"VideoInfoView" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.tableView.delegate = self.delegate;
    self.tableView.dataSource = self.dataSource;
    self.textField.delegate = self;
}







@end
