//
//  SPS_FileTool.h
//  SPSTool
//
//  Created by ZhongSpace on 16/8/25.
//  Copyright © 2016年 ZhongSpace. All rights reserved.
// 文件管理工具

/**
 *用户生成的文件放在documents，自己的文件放在library/cache里面---------by apple
 
 简单的说明：如果你做个记事本的app，那么用户写了东西，总要把东西存起来。那么这个文件则是用户自行生成的，就放在documents文件夹里面。
 
 如果你有一个app，需要和服务器配合，经常从服务器下载东西，展示给用户看。那么这些下载下来的东西就放在library/cache。
 
 apple对这个很严格，放错了就会被拒。主要原因是ios的icloud的同步问题。
 */

#import <Foundation/Foundation.h>

static NSString * const SPS_DefaultFolderName = @"SPS_DefaultFolder";

@interface SPS_FileTool : NSObject


/*
 *创建文件到Document下指定的文件,是否要覆盖。返回创建文件的路劲
 */
+(NSString *)createDocumentFile:(NSString *)fileName replace:(BOOL)re;

/**
 * 创建文件到LibrayCache下指定的文件。返回创建文件的路劲
 */
+(NSString *)createLibrayCacheFile:(NSString *)fileName replace:(BOOL)re;

/**
 * 获取根据文件夹名字在documents创建文件夹
 */
+(NSString *)createFolderInDocumentsWithFolderName:(NSString *)folderName;

/**
 * 获取根据文件夹名字在LibrayCache创建文件夹
 * folderName: 文件夹名称 传nil会创建默认文件夹名
 */
+(NSString *)createFolderInLibrayCacheWithName:(NSString *)folderName;

/**
 * 获取LibrayCache的路径
 */
+(NSString *)getLibrayCachePath;

/**
 * 获取Document的路径
 */
+(NSString *)getDocumentPath;

/**
 * 获取指定文件路径的修改时间
 * filePath : 文件路径
 */
+(NSTimeInterval)getFileModifyTimeWithFilePath:(NSString *)filePath;


/**
 * 返回文件最近一次被修改的时间和现在的时间差，若文件不存在，则返回-1
 * fileName : 文件名字
 * folderName : 文件夹名字 传nil会默认SPS_DefaultFolderName
 */
+(NSTimeInterval)getCacheFileModifyTimeWithFileName:(NSString * )fileName FolderName:(NSString *)folderName;

/**
 * 根据路径删除文件
 */
+(void)deleteFileOrDire:(NSString *)filePath;


@end
