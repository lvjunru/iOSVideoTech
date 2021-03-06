//
//  CollectionCell.m
//  简单的ffmpeg播放器
//
//  Created by ZhongSpace on 2017/5/17.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "CollectionCell.h"
#import "CellModel.h"

@interface CollectionCell ()


@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@end

@implementation CollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0];
    
    self.infoLabel.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0];
    
}

-(void)setModel:(CellModel *)model
{
    _model = model;
    
    self.infoLabel.text = model.Navtitle;
}

@end
