//
//  CustomNavVC.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/6/19.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "CustomNavVC.h"
#import "iOSVideoTechConst.h"

@interface CustomNavVC ()

@end

@implementation CustomNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 全局设置导航栏

+(void)initialize
{
    //定义全局的导航栏
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //改变背景颜色
    navBar.barTintColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0];
    
    //修改导航栏标题颜色,文字大小,文字种类
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:globalTextColor}];
    
    //修改文字
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:globalTextColor} forState:UIControlStateNormal];
}



@end
