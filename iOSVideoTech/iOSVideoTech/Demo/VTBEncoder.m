//
//  VTBDecoder.m
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/6/8.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import "VTBEncoder.h"
#import <VideoToolbox/VideoToolbox.h>
#import "SPS_FileTool.h"

@interface VTBEncoder()

/** 文件写入对象 */
@property (nonatomic, strong) NSFileHandle *fileHandle;

/**
 * iOS 原生硬解码(GPU加速)
 */
@property(nonatomic,assign)VTCompressionSessionRef  compressionSession;

@property(nonatomic,assign)NSUInteger frameID;


@end

@implementation VTBEncoder

-(instancetype)init
{
    if (self = [super init]) {
        
        NSString * filePath =  [SPS_FileTool createDocumentFile:@"abc.h264" replace:YES];
        if (filePath) {
            // 3.创建对象
            self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        }
        
        self.frameID = 0;
    }
    return self;
}

-(void)setupVideoCompressionWidth:(CGFloat)width Height:(CGFloat)height
{
    if (width <=0)
        width = [UIScreen mainScreen].bounds.size.width;
    if (height <=0)
        height = [UIScreen mainScreen].bounds.size.height;
    
    //1创建compressionSession
    VTCompressionSessionCreate(NULL, width, height, kCMVideoCodecType_H264, NULL, NULL, NULL, &VTCompressionCallback, (__bridge void *)(self),  &_compressionSession);
    
    //----2设置compressionSession的参数
    //2.1设置为实时输出视频
    VTSessionSetProperty(self.compressionSession, kVTCompressionPropertyKey_RealTime, kCFBooleanTrue);
    
    //2.2 设置期望帧率
    int fps = 30;
    CFNumberRef fpsRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &fps);
    VTSessionSetProperty(self.compressionSession, kVTCompressionPropertyKey_ExpectedFrameRate, fpsRef);
    
    //2.3率(码率: 编码效率, 码率越高,则画面越清晰, 如果码率较低会引起马赛克 --> 码率高有利于还原原始画面,但是也不利于传输)
    int bitRate = 800*1024;
    CFNumberRef bitRateRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &bitRate);
    VTSessionSetProperty(self.compressionSession,kVTCompressionPropertyKey_AverageBitRate,bitRateRef);
    
    //暂时不清楚这个属性的作用
    NSArray *limit = @[@(bitRate * 1.5/8), @(1)];
    VTSessionSetProperty(self.compressionSession, kVTCompressionPropertyKey_DataRateLimits, (__bridge CFArrayRef)limit);
    
    // 2.4设置关键帧（GOPsize)间隔，这个参数也称为关键帧率。
    int frameInterval = 30;
    CFNumberRef  frameIntervalRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &frameInterval);
    VTSessionSetProperty(self.compressionSession, kVTCompressionPropertyKey_MaxKeyFrameInterval, frameIntervalRef);
    
    // 8.基本设置结束, 准备进行编码，预分配一些资源。如果不调用，编码资源测就会在VTCompressionSessionEncodeFrame，分配
    VTCompressionSessionPrepareToEncodeFrames(self.compressionSession);
    
}

/**
 *typedef void (*VTCompressionOutputCallback)(void *outputCallbackRefCon, void *sourceFrameRefCon, OSStatus status, VTEncodeInfoFlags infoFlags, CMSampleBufferRef sampleBuffer);
 */

void VTCompressionCallback(void *outputCallbackRefCon, void *sourceFrameRefCon, OSStatus status, VTEncodeInfoFlags infoFlags, CMSampleBufferRef sampleBuffer){
    
    if (status != noErr) {
        NSLog(@"Compress-ERROR");
        return;
    }
    
    
    VTBEncoder * encoder = (__bridge VTBEncoder*)outputCallbackRefCon;
    
    // 3.判断是否是关键帧
    bool isKeyframe = !CFDictionaryContainsKey( (CFArrayGetValueAtIndex(CMSampleBufferGetSampleAttachmentsArray(sampleBuffer, true), 0)), kCMSampleAttachmentKey_NotSync);
    // 判断当前帧是否为关键帧
    // 获取sps & pps数据
    if (isKeyframe) {
        // 获取编码后的信息（存储于CMFormatDescriptionRef中）
        CMFormatDescriptionRef format = CMSampleBufferGetFormatDescription(sampleBuffer);
        
        // 获取SPS信息
        size_t sparameterSetSize, sparameterSetCount;
        const uint8_t *sparameterSet;
        CMVideoFormatDescriptionGetH264ParameterSetAtIndex(format, 0, &sparameterSet, &sparameterSetSize, &sparameterSetCount, 0 );
        
        // 获取PPS信息
        size_t pparameterSetSize, pparameterSetCount;
        const uint8_t *pparameterSet;
        CMVideoFormatDescriptionGetH264ParameterSetAtIndex(format, 1, &pparameterSet, &pparameterSetSize, &pparameterSetCount, 0 );
        
        // 装sps/pps转成NSData，以方便写入文件
        NSData *sps = [NSData dataWithBytes:sparameterSet length:sparameterSetSize];
        NSData *pps = [NSData dataWithBytes:pparameterSet length:pparameterSetSize];
        
        // 写入文件
        [encoder gotSpsPps:sps pps:pps];
    }
    
    
    // 获取数据块
    CMBlockBufferRef dataBuffer = CMSampleBufferGetDataBuffer(sampleBuffer);
    size_t length, totalLength;
    char *dataPointer;
    OSStatus statusCodeRet = CMBlockBufferGetDataPointer(dataBuffer, 0, &length, &totalLength, &dataPointer);
    if (statusCodeRet == noErr) {
        size_t bufferOffset = 0;
        static const int AVCCHeaderLength = 4; // 返回的nalu数据前四个字节不是0001的startcode，而是大端模式的帧长度length
        
        // 循环获取nalu数据
        while (bufferOffset < totalLength - AVCCHeaderLength) {
            uint32_t NALUnitLength = 0;
            // Read the NAL unit length
            memcpy(&NALUnitLength, dataPointer + bufferOffset, AVCCHeaderLength);
            
            // 从大端转系统端
            NALUnitLength = CFSwapInt32BigToHost(NALUnitLength);
            
            NSData* data = [[NSData alloc] initWithBytes:(dataPointer + bufferOffset + AVCCHeaderLength) length:NALUnitLength];
            [encoder gotEncodedData:data isKeyFrame:isKeyframe];
            
            // 移动到写一个块，转成NALU单元
            // Move to the next NAL unit in the block buffer
            bufferOffset += AVCCHeaderLength + NALUnitLength;
        }
    }
    
}

- (void)gotSpsPps:(NSData*)sps pps:(NSData*)pps
{
    // 1.拼接NALU的header
    const char bytes[] = {0x00,0x00,0x00,0x01};
    size_t length = (sizeof bytes) - 1;
    NSData *ByteHeader = [NSData dataWithBytes:bytes length:length];
    
    // 2.将NALU的头&NALU的体写入文件
    [self.fileHandle writeData:ByteHeader];
    [self.fileHandle writeData:sps];
    [self.fileHandle writeData:ByteHeader];
    [self.fileHandle writeData:pps];
    
}

- (void)gotEncodedData:(NSData*)data isKeyFrame:(BOOL)isKeyFrame
{
    NSLog(@"gotEncodedData %d", (int)[data length]);
    if (self.fileHandle != NULL)
    {
        const char bytes[] = "\x00\x00\x00\x01";
        size_t length = (sizeof bytes) - 1; //string literals have implicit trailing '\0'
        NSData *ByteHeader = [NSData dataWithBytes:bytes length:length];
        [self.fileHandle writeData:ByteHeader];
        [self.fileHandle writeData:data];
    }
}

- (void)encode:(CMSampleBufferRef)sampleBuffer {
    // 1.将sampleBuffer转成imageBuffer
    CVImageBufferRef imageBuffer = (CVImageBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
    
    // 2.根据当前的帧数,创建CMTime的时间(待测试)
    CMTime presentationTimeStamp = CMTimeMake(self.frameID++, 1000);
    VTEncodeInfoFlags flags;
    
    // 3.开始编码该帧数据
    OSStatus statusCode = VTCompressionSessionEncodeFrame(self.compressionSession,
                                                          imageBuffer,
                                                          presentationTimeStamp,
                                                          kCMTimeInvalid,
                                                          NULL, (__bridge void * _Nullable)(self), &flags);
    if (statusCode == noErr) {
        NSLog(@"H264: VTCompressionSessionEncodeFrame Success");
    }
}

- (void)endEncode {
    VTCompressionSessionCompleteFrames(self.compressionSession, kCMTimeInvalid);
    VTCompressionSessionInvalidate(self.compressionSession);
    CFRelease(self.compressionSession);
    self.compressionSession = NULL;
}

@end
