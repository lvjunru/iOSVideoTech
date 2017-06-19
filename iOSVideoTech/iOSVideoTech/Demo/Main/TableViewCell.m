//
//  TableViewCell.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/6/19.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "TableViewCell.h"
#import "CellModel.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellM:(CellModel *)cellM
{
    _cellM = cellM;
    self.textLabel.text = cellM.cellTitle;
    self.detailTextLabel.text = cellM.cellDetailTitle;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
