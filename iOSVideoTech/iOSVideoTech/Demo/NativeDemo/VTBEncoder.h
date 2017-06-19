//
//  VTBDecoder.h
//  iOSVideoTech
//
//  Created by ZhongSpace on 2017/6/8.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VideoToolbox/VideoToolbox.h>

@interface VTBEncoder : NSObject

/**
 * path 指定编码的路径
 */
-(instancetype)initWithEncodePath:(NSString *)path;

/**
 * 编码CMSampleBufferRef
 */
- (void)encode:(CMSampleBufferRef)sampleBuffer;


- (void)endEncode;

@end
