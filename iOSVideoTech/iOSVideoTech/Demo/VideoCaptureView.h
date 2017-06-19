//
//  VideoCaptureView.h
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/5/30.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoCaptureView;
@protocol VideoCaptureViewDelegate <NSObject>

-(void)VideoCaptureView:(VideoCaptureView *)view startButtonClick:(UIButton *)btn;

-(void)VideoCaptureView:(VideoCaptureView *)view stopButtonClick:(UIButton *)btn;

-(void)VideoCaptureView:(VideoCaptureView *)view switchButtonClick:(UIButton *)btn;


-(void)VideoCaptureView:(VideoCaptureView *)view saveButtonClick:(UIButton *)btn;

@end

@interface VideoCaptureView : UIView

+(instancetype)captureView;
@property(nonatomic,weak)id<VideoCaptureViewDelegate>delegate;

@end
