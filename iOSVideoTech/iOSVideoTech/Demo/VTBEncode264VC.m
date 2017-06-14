//
//  VTBEncode264VC.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/5/31.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "VTBEncode264VC.h"
#import "ChangeToH264View.h"
#import "VTBEncoder.h"

@interface VTBEncode264VC ()<ChangeToH264ViewDelegate>

@property(nonatomic,weak)ChangeToH264View * changeToH264View;

@property(nonatomic,strong)VTBEncoder * encoder;

@end

@implementation VTBEncode264VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0];
    ChangeToH264View * changeToH264View = [ChangeToH264View changeToH264View];
    
    changeToH264View.delegate = self;
    changeToH264View.frame = self.view.bounds;
    [self.view addSubview:changeToH264View];
    self.changeToH264View = changeToH264View;
    
    self.encoder = [[VTBEncoder alloc] init];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ChangeToH264ViewDelegate

-(void)ChangeToH264View:(ChangeToH264View *)changeView changeButtonClick:(UIButton *)button
{
    
}

@end


