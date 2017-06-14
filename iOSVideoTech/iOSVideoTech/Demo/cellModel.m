//
//  cellModel.m
//  简单的ffmpeg播放器
//
//  Created by ZhongSpace on 2017/5/17.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "cellModel.h"

@implementation cellModel

-(instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        
        self.title = title;
    }
    return self;
}


@end
