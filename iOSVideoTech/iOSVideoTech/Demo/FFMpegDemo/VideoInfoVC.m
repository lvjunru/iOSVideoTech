//
//  VideoInfoVC.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/6/21.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "VideoInfoVC.h"
#import "VideoInfoView.h"
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#import "VideoInfoModel.h"


static NSString * cellID = @"cellID";

@interface VideoInfoVC ()<UITableViewDataSource,UITableViewDelegate>
{
    AVFormatContext * _pFormatCtx;
    AVCodecContext * _pCodeCtx;
    AVCodec * pCode;
}

@property(nonatomic,weak)VideoInfoView * videoInfoView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation VideoInfoVC

#warning TODO tableView高度和代理问题

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    VideoInfoView * videoInfoView = [VideoInfoView videoInfoView];
    videoInfoView.dataSource = self;
    videoInfoView.delegate = self;
    [self.view addSubview:videoInfoView];
    self.videoInfoView = videoInfoView;
    [self setupFFMpeg];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.videoInfoView.frame = self.view.bounds;
}

-(void)setupFFMpeg
{
    //初始化FFMpeg组件
    av_register_all();
    
    //获取解码器
    _pFormatCtx = avformat_alloc_context();
    
    self.videoInfoView.textDidChangeBlock = ^(NSString *text){
        
        if(avformat_open_input(&_pFormatCtx, text.UTF8String, NULL, NULL)!=0){
            
            [self showAlert:@"不能打开流"];
        };
        
    };
    
}

#pragma mark UITableViewDataSource UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
