//
//  VideoCaptureView.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/5/30.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "VideoCaptureView.h"

@interface VideoCaptureView()

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@end

@implementation VideoCaptureView

+(instancetype)captureView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"VideoCaptureView" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0];
}
- (IBAction)startButtonClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(VideoCaptureView:startButtonClick:)]) {
        [self.delegate VideoCaptureView:self startButtonClick:sender];
    }
}
- (IBAction)stopButtonClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(VideoCaptureView:stopButtonClick:)]) {
        [self.delegate VideoCaptureView:self stopButtonClick:sender];
    }
}

- (IBAction)switchButtonClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(VideoCaptureView:switchButtonClick:)]) {
        [self.delegate VideoCaptureView:self switchButtonClick:sender];
    }
}
- (IBAction)saveButtonClikc:(UIButton *)sender {
    
    
}

@end
