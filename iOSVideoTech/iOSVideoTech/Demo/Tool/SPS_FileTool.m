//
//  SPS_FileTool.m
//  SPSTool
//
//  Created by ZhongSpace on 16/8/25.
//  Copyright © 2016年 ZhongSpace. All rights reserved.
//

#import "SPS_FileTool.h"

@implementation SPS_FileTool

//创建文件到LibrayCache下指定的文件。
+(NSString * )createDocumentFile:(NSString *)fileName replace:(BOOL)re
{
    if ([fileName isEqualToString:@""] || fileName == nil ){
        NSLog(@"请输入有效的文件名字");
        return nil;
    }
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString * filePath = [path stringByAppendingPathComponent:fileName];
    
    return [self createFileAtPath:filePath replace:re];
}

//创建文件到LibrayCache下指定的文件。
+(NSString * )createLibrayCacheFile:(NSString *)fileName replace:(BOOL)re
{
    if ([fileName isEqualToString:@""] || fileName == nil ){
        NSLog(@"请输入有效的文件名字");
        return nil;
    }
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString * filePath = [path stringByAppendingPathComponent:fileName];
    
     return [self createFileAtPath:filePath replace:re];

}

/**
 * 获取根据文件夹名字在documents创建文件夹
 * folderName: 文件夹名称 传nil会创建默认文件夹名
 */
+(NSString *)createFolderInDocumentsWithFolderName:(NSString *)folderName
{
    if ([folderName isEqualToString:@""] || folderName == nil)
        folderName = SPS_DefaultFolderName;
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * folderPath = [path stringByAppendingPathComponent:folderName];
    
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL isDir;
    //如果不存在这个文件夹
    if (![manager fileExistsAtPath:folderPath isDirectory:&isDir]) {
        
        return  [self createFolderInPath:folderPath];
        
    }else  //如果存在这个文件夹
    {
        if (!isDir) { //如果存在同名的文件，则删除文件并且创建文件夹
            NSError * error = nil;
            [manager removeItemAtPath:folderPath error:&error];
            return [self createFolderInPath:folderPath];
        }
        return folderPath;
    }
}


//在LibrayCache创建默认的指定文件夹名字
+(NSString *)createFolderInLibrayCacheWithName:(NSString *)folderName
{
    if ([folderName isEqualToString:@""] || folderName == nil)
        folderName = SPS_DefaultFolderName;
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString * folderPath = [path stringByAppendingPathComponent:folderName];
    
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL isDir;
    //如果不存在这个文件夹
    if (![manager fileExistsAtPath:folderPath isDirectory:&isDir]) {
        
        return  [self createFolderInPath:folderPath];
        
    }else  //如果存在这个文件夹
    {
        if (!isDir) { //如果存在同名的文件，则删除文件并且创建文件夹
            NSError * error = nil;
            [manager removeItemAtPath:folderPath error:&error];
            return [self createFolderInPath:folderPath];
        }
        return folderPath;
    }
}


+(NSString * )createFileAtPath:(NSString *)path
{
    //创建文件
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL isOkay = NO;
    //If a file already exists at path, this method overwrites the contents of that file if the current process has the appropriate privileges to do so.默认会覆盖
    isOkay = [manager createFileAtPath:path contents:nil attributes:nil];
    if (isOkay)
        return path;
    else
        return nil;
}

+(NSString * )createFileAtPath:(NSString *)path replace:(BOOL)re
{
    //创建文件
    NSFileManager * manager = [NSFileManager defaultManager];
    
    BOOL isOkay = NO;
    if (![manager fileExistsAtPath:path isDirectory:nil]) {
        isOkay = [manager createFileAtPath:path contents:nil attributes:nil];
        if (isOkay)
            return path;
        else
            return nil;
        
    }else
    {
        if (re) {
            return [self createFileAtPath:path];
        }else
        {
            NSLog(@"文件已经存在");
            return path;
        }
    }
    
}

//根据路径创建文件夹
+(NSString *)createFolderInPath:(NSString *)path
{
    NSFileManager * manager = [NSFileManager defaultManager];
    __autoreleasing NSError * error = nil;
    [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"create DefalutFolder Failure!=%@",error);
        return nil;
    }
    return path;
}


+(NSString *)getLibrayCachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString *)getDocumentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

//获取指定文件路径的修改时间
+(NSTimeInterval)getFileModifyTimeWithFilePath:(NSString *)filePath;
{
    NSFileManager * manager = [NSFileManager defaultManager];
    NSError * error = nil;
    NSDictionary * attributes = [manager attributesOfItemAtPath:filePath error:&error];
    if (!attributes) {
        NSLog(@"无法获取到指定文件的属性==%@",error);
        return -1;
    }
    int seconds = -[[attributes fileModificationDate] timeIntervalSinceNow];
    return seconds;
}

//返回Cache文件创建的时间，若文件不存在，则返回-1；
+(NSTimeInterval)getCacheFileModifyTimeWithFileName:(NSString * )fileName FolderName:(NSString *)folderName
{
    if ([folderName isEqualToString:@""] || folderName == nil)
        folderName = SPS_DefaultFolderName;
    if ([fileName isEqualToString:@""] || fileName == nil ){
        NSLog(@"请输入有效的文件名字");
        return -1;
    }
    NSFileManager * manager = [NSFileManager defaultManager];
    NSError * error = nil;
    NSString * path = [[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:fileName];
    NSDictionary * attributes = [manager attributesOfItemAtPath:path error:&error];
    if (!attributes) {
        NSLog(@"无法获取到指定文件的属性==%@",error);
        return -1;
    }
    int seconds = -[[attributes fileModificationDate] timeIntervalSinceNow];
    return seconds;
}

//根据路径删除文件
+(void)deleteFileOrDire:(NSString *)filePath
{
    if ([filePath isEqualToString:@""] || filePath == nil) {
        NSLog(@"请输入有效的文件名字");
        return;
    }
    NSFileManager * manager = [NSFileManager defaultManager];
    NSError * error = nil;
    if ([manager fileExistsAtPath:filePath isDirectory:nil]) {
        [manager removeItemAtPath:filePath error:&error];
    }else
    {
        NSLog(@"找不到删除的文件");
    }
}


@end
