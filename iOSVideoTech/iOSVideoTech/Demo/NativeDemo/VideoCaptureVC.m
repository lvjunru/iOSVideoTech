//
//  VideoCaptureVC.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/5/30.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "VideoCaptureVC.h"
#import "VideoCaptureView.h"
#import <AVFoundation/AVFoundation.h>
#import "VTBEncoder.h"

@interface VideoCaptureVC()<VideoCaptureViewDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>

@property(nonatomic,weak)VideoCaptureView * captureView;

/**
 * 用来捕获iPhone视频流的session
 */
@property(nonatomic,strong)AVCaptureSession * captureSession;


/**
 * 预览图层
 */
@property(nonatomic,strong)AVCaptureVideoPreviewLayer * preLayer;

/**
 * queue
 */
@property (nonatomic, strong) dispatch_queue_t captureQueue;


/**
 * Videotoolbox编码对象
 */
@property(nonatomic,strong)VTBEncoder * encoder;

/**
 * 是否写入文件
 */
@property(nonatomic,assign)BOOL shouldWriteToFile;


@end

@implementation VideoCaptureVC


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    VideoCaptureView * captureView = [VideoCaptureView captureView];
    captureView.frame = self.view.bounds;
    captureView.delegate = self;
    [self.view addSubview:captureView];
    self.captureView = captureView;
    self.shouldWriteToFile = NO;
    
    self.encoder = [[VTBEncoder alloc] init];
}


#pragma mark VideoCaptureViewDelegate

-(void)VideoCaptureView:(VideoCaptureView *)view startButtonClick:(UIButton *)btn
{
    //创建不抓session对象
    AVCaptureSession *  captureSession = [[AVCaptureSession alloc] init];
    
    captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
    
    self.captureSession = captureSession;
    
    //创建设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError * error = nil;
    
    //获取添加输出设备
    AVCaptureDeviceInput * input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    [captureSession addInput:input];
    
    //获取添加输出设备
    AVCaptureVideoDataOutput * output = [[AVCaptureVideoDataOutput alloc] init];
    [output setSampleBufferDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [captureSession addOutput:output];
    
    //设置录制屏幕的方向
    AVCaptureConnection * connection = [output connectionWithMediaType:AVMediaTypeVideo];
    [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    
    //添加预览图层
    AVCaptureVideoPreviewLayer * preLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
    preLayer.frame = self.view.bounds;
    [self.captureView.layer insertSublayer:preLayer atIndex:0];
    self.preLayer = preLayer;
    
    [captureSession startRunning];

}

-(void)VideoCaptureView:(VideoCaptureView *)view stopButtonClick:(UIButton *)btn
{
   [self stopCapture];
}

-(void)VideoCaptureView:(VideoCaptureView *)view switchButtonClick:(UIButton *)btn
{
    
    if(_captureSession)
    {
        //配置captureSession Indicate that some changes will be made to the session
        [_captureSession beginConfiguration];
        
        //移除之前的input
        AVCaptureInput* currentCameraInput = [_captureSession.inputs objectAtIndex:0];
        [_captureSession removeInput:currentCameraInput];
        
        //生成新的input
        AVCaptureDevice *newCamera = nil;
        if(((AVCaptureDeviceInput*)currentCameraInput).device.position == AVCaptureDevicePositionBack)
        {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
        }
        else
        {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }
        
        //Add input to session
        NSError *err = nil;
        AVCaptureDeviceInput *newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:newCamera error:&err];
        if(!newVideoInput || err)
        {
            NSLog(@"Error creating capture device input: %@", err.localizedDescription);
        }
        else
        {
            [_captureSession addInput:newVideoInput];
        }
        
        //提交所有配置 Commit all the configuration changes at once
        [_captureSession commitConfiguration];
    }
}

// Find a camera with the specified AVCaptureDevicePosition, returning nil if one is not found
- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position
{
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
#pragma GCC diagnostic pop
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == position) return device;
    }
    return nil;
}


-(void)stopCapture
{
    [self.captureSession stopRunning];
    [self.preLayer removeFromSuperlayer];
    [self.encoder endEncode];
}


#pragma mark AVCaptureVideoDataOutputSampleBufferDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    //didDropSampleBuffer丢弃的帧
   
    
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
    [self.encoder encode:sampleBuffer];
    
}


-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}




@end
