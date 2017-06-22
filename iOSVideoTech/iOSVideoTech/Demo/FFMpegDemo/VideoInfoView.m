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
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.tableView.delegate = self.delegate;
    self.tableView.dataSource = self.dataSource;
}

- (IBAction)confirmButtonClick:(UIButton *)sender {
    
    if (self.textDidChangeBlock) {
        self.textDidChangeBlock(self.textField.text);
    }
}


-(void)textChanged:(UITextField *)textField
{
    
}


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    return [super hitTest:point withEvent:event];
}

@end
