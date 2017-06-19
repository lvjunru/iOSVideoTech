//
//  ChangeToH264View.m
//  简单的ffmpeg播放器
//
//  Created by ZhongSpace on 2017/5/17.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "ChangeToH264View.h"

@interface ChangeToH264View ()

@property (weak, nonatomic) IBOutlet UITextField *destTextField;

@property (weak, nonatomic) IBOutlet UITextField *sourcePathTextField;

@property (weak, nonatomic) IBOutlet UIButton *changeButton;


@end

@implementation ChangeToH264View

+(instancetype)changeToH264View
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ChangeToH264View" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.sourcePathTextField.enabled = NO;
}

- (IBAction)changeButtonClick:(UIButton *)button {
    if (_sourcePathTextField.text.length <=0) {
        
        [self showAlertWithTitle:@"源路径为空"];
        
        return;
    }
    
    if (_destTextField.text.length <=0) {
        
        [self showAlertWithTitle:@"目标路径为空"];
        
        return;
    }
    if ([self.delegate respondsToSelector:@selector(ChangeToH264View:changeButtonClick:)]) {
        [self.delegate ChangeToH264View:self changeButtonClick:button];
    }
    
}

-(NSString *)getSourcePath
{
    return _sourcePathTextField.text;
}
-(NSString *)getDestPath
{
    return _destTextField.text;
}

-(void)setSource:(NSString *)path
{
    self.sourcePathTextField.text = path;
}

-(void)showAlertWithTitle:(NSString *)title
{
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"title" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
}

@end
