//
//  VideoInfoView.h
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/6/21.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VideoInfoView : UIView

+(instancetype)videoInfoView;

@property(nonatomic,copy) void(^textDidChangeBlock)(NSString *text);

@property(nonatomic,weak)id<UITableViewDelegate> delegate;

@property(nonatomic,weak)id<UITableViewDataSource> dataSource;

@end
