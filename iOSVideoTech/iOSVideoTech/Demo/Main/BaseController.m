//
//  BaseController.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/6/19.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "BaseController.h"
#import "iOSVideoTechConst.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置返回按钮的样式
    UIButton * leftButton  = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50,50)];
    [leftButton setTitle:@"BACK" forState:UIControlStateNormal];
    [leftButton setTitleColor:globalTextColor forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)showAlert:(NSString *)msg
{
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"信息" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:action];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
    
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
