//
//  ChangeToH264View.h
//  简单的ffmpeg播放器
//
//  Created by ZhongSpace on 2017/5/17.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChangeToH264View;

@protocol ChangeToH264ViewDelegate <NSObject>

-(void)ChangeToH264View:(ChangeToH264View*)changeView changeButtonClick:(UIButton *)button;

@end

@interface ChangeToH264View : UIView

@property(nonatomic,weak)id<ChangeToH264ViewDelegate>  delegate;


+(instancetype)changeToH264View;

-(void)setSource:(NSString *)path;

-(NSString *)getSourcePath;
-(NSString *)getDestPath;

@end
