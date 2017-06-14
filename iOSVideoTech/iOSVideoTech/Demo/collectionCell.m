//
//  collectionCell.m
//  简单的ffmpeg播放器
//
//  Created by ZhongSpace on 2017/5/17.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "collectionCell.h"
#import "cellModel.h"

@interface collectionCell ()


@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@end

@implementation collectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0];
    
    self.infoLabel.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0];
    
}

-(void)setModel:(cellModel *)model
{
    _model = model;
    
    self.infoLabel.text = model.title;
}

@end
