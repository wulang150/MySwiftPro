//
//  NetManager.m
//  MyProject
//
//  Created by  Tmac on 2017/7/20.
//  Copyright © 2017年 Tmac. All rights reserved.
//

#import "NetManager.h"
#import "NetWorkBase.h"

@implementation NetManager

//设备记录数据的上传
+ (void)uploadDeviceRecord:(NSString *)filepath callBack:(void(^)(BOOL succ,NSString *ret))callBack
{
    NSString *url = @"https://edhr.smartfenda.com/upload/";
    NSDictionary *dic = @{@"orderNum":@"100"};
    
    NSString *file = [LAFileManager getTextFromPath:filepath];
    
    if(file.length<=0)
    {
        if(callBack)
            callBack(NO,@"文件没有内容！");
        return;
    }
    
    file = [file md5];
    
    NetWorkBase *net = [[NetWorkBase alloc] init];
    net.httpHeaderFields = @{@"content-md5":file};
    net.needAppendRequestHeader = YES;
    [net uploadFile:url parameters:dic filePath:filepath withType:File_Xml withBlock:^(id result, BOOL succ) {
        
        NSString *ss = [NSString stringWithFormat:@"%@",result];
        if(callBack)
            callBack(succ,ss);
    }];
}

//设备报告与签名的上传
+ (void)uploadsignReport:(NSString *)file1 file2:(NSString *)file2 callBack:(void(^)(BOOL succ,NSString *ret))callBack
{
    NSString *url = @"https://edhr.smartfenda.com/upload/";
    NSDictionary *dic = @{@"orderNum":@"101"};
    
    NSString *srcFile = [LAFileManager getTextFromPath:file1];
    NSString *decFile = [LAFileManager getTextFromPath:file2];
    
    if(srcFile.length<=0||decFile.length<=0)
    {
        if(callBack)
            callBack(NO,@"文件没有内容！");
        return;
    }
    
    srcFile = [srcFile md5];
    decFile = [decFile md5];
    
    NetWorkBase *net = [[NetWorkBase alloc] init];
    net.httpHeaderFields = @{@"content-md5":[NSString stringWithFormat:@"%@:%@",srcFile,decFile]};
    net.needAppendRequestHeader = YES;
    [net uploadFiless:url parameters:dic fileArray:@[file1,file2] withType:File_Xml withBlock:^(id result, BOOL succ) {
        
        if(callBack)
            callBack(succ,result);
    }];
}

//设备UDI数据的上传
+ (void)uploadUDI:(NSString *)filepath callBack:(void(^)(BOOL succ,NSString *ret))callBack
{
    NSString *url = @"https://edhr.smartfenda.com/upload/";
    NSDictionary *dic = @{@"orderNum":@"102"};
    
    NSString *file = [LAFileManager getTextFromPath:filepath];
    
    if(file.length<=0)
    {
        if(callBack)
            callBack(NO,@"文件没有内容！");
        return;
    }
    
    file = [file md5];
    
    NetWorkBase *net = [[NetWorkBase alloc] init];
    net.httpHeaderFields = @{@"content-md5":file};
    net.needAppendRequestHeader = YES;
    [net uploadFile:url parameters:dic filePath:filepath withType:File_Xml withBlock:^(id result, BOOL succ) {
        
        if(callBack)
            callBack(succ,result);
    }];
}

//设备ASN数据的上传
+ (void)uploadASN:(NSString *)filepath callBack:(void(^)(BOOL succ,NSString *ret))callBack
{
    NSString *url = @"https://edhr.smartfenda.com/upload/";
    NSDictionary *dic = @{@"orderNum":@"103",
                          @"guid":@"10000",
                          @"override":@"u"};
    
    NSString *file = [LAFileManager getTextFromPath:filepath];
    
    if(file.length<=0)
    {
        if(callBack)
            callBack(NO,@"文件没有内容！");
        return;
    }
    
    file = [file md5];
    
    NetWorkBase *net = [[NetWorkBase alloc] init];
    net.httpHeaderFields = @{@"content-md5":file};
    net.needAppendRequestHeader = YES;
    [net uploadFile:url parameters:dic filePath:filepath withType:File_Xml withBlock:^(id result, BOOL succ) {
        
        if(callBack)
            callBack(succ,result);
    }];
}
@end
