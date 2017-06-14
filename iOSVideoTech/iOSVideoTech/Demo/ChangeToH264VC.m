//
//  ChangeToH264.m
//  简单的ffmpeg播放器
//
//  Created by ZhongSpace on 2017/5/17.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "ChangeToH264VC.h"
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libswscale/swscale.h"
#import "cellModel.h"
#import "ChangeToH264View.h"
#import "SVProgressHUD.h"

@interface ChangeToH264VC ()<ChangeToH264ViewDelegate>
{
    AVFormatContext * pFormatCtx;
    int i , videoIndex;
    AVCodecContext * pCodeCtx;
    AVCodec * pCode;
    AVFrame * pFrame,*pFrameYUV;
    uint8_t * out_Buffer;
    AVPacket * packet;
    int y_size;
    int ret, got_picture;
    struct SwsContext * img_convert_ctx;
    int frame_cnt;
    AVPicture picture;
}

@property(nonatomic,weak)ChangeToH264View * changeToH264View;

@end

@implementation ChangeToH264VC


#pragma mark  life-cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0];
    ChangeToH264View * changeToH264View = [ChangeToH264View changeToH264View];
    
    NSString * sourcePath = [[NSBundle mainBundle]pathForResource:@"Titanic.ts" ofType:nil];
    [changeToH264View setSource:sourcePath];
    changeToH264View.delegate = self;
    changeToH264View.frame = self.view.bounds;
    
    
    [self.view addSubview:changeToH264View];
    self.changeToH264View = changeToH264View;
    
    [self setupFFMpeg];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)setupFFMpeg
{
    //启动FFMPEG模块,调用avcodec_register_all()注册编解码器,注册一堆东西，看不懂-.-!
    av_register_all();

    //注册网络协议()
//    avformat_network_init();
    
    pFormatCtx = avformat_alloc_context();
    
}

#pragma mark ChangeToH264ViewDelegate

-(void)ChangeToH264View:(ChangeToH264View *)changeView changeButtonClick:(UIButton *)button
{
    
    [SVProgressHUD showWithStatus:@"转码中"];
    NSString * sourcePath = [changeView getSourcePath];
    NSString * destPath = [changeView getDestPath];
    //avformat_open_input 返回0表示成功
    if (avformat_open_input(&pFormatCtx, sourcePath.UTF8String, NULL, NULL)!=0){
        NSLog(@"不能打开流");
        return;
    }
    //读取流信息
    if (avformat_find_stream_info(pFormatCtx, NULL) < 0) {
        NSLog(@"不能读取到流信息");
        return;
    }
    videoIndex = -1;
    //nb_streams 与 streams 有什么区别
    for (i  = 0; i < pFormatCtx->nb_streams; i ++) {
        //如果是视频流
        if (pFormatCtx ->streams[i]->codec->codec_type == AVMEDIA_TYPE_VIDEO) {
            videoIndex = i;
            break;
        }
        if (videoIndex == -1) {
            NSLog(@"没有视频流");
            return;
        }
    }
    pCodeCtx = pFormatCtx->streams[videoIndex]->codec;
    pCode = avcodec_find_decoder(pCodeCtx->codec_id);
    if (pCode == NULL) {
        NSLog(@"找不到解码器");
        return;
    }
    if (avcodec_open2(pCodeCtx, pCode, NULL) < 0) {
        NSLog(@"不能打开解码器");
        return;
    }
    
    packet = (AVPacket *)av_malloc(sizeof(AVPacket));
    //打来文件操作句柄
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FILE * h264 = fopen(destPath.UTF8String, "wb+");
        //循环读取码流
        while(av_read_frame(pFormatCtx, packet)>=0)
        {
            NSLog(@"packet->data==%d",packet->size);
            //视频帧
            if (packet->stream_index == videoIndex) {
                fwrite(packet->data,1, packet->size, h264);
            }
        }
        avcodec_close(pCodeCtx);
        avformat_close_input(&pFormatCtx);
        fclose(h264);
        dispatch_sync(dispatch_get_main_queue(), ^{
           [SVProgressHUD showWithStatus:@"转码完成"];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
    

}


@end
