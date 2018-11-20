//
//  FDNetManager.h
//  Runner
//
//  Created by  Tmac on 16/3/11.
//  Copyright © 2016年 Janson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^FdCallFun)(id result,BOOL succ);

enum{
    NET_FILE_IMAGE = 1,
    NET_FILE_AUDIO_PCM,
    NET_FILE_VCf
};

@interface FDNetManager : NSObject

+ (FDNetManager *)shareInstance;
- (BOOL)isReachable;
//网络变化，会有回调
- (void)reachNetWorkWithBlock:(void (^)(BOOL blean))block;

- (void)startPost:(NSString *)serverUrl params:(NSDictionary *)params callBack:(FdCallFun)callBack;

//上传文件
- (void)startUpLoadFile:(NSString *)url fileType:(int)fileType params:(NSDictionary *)params fileUrl:(NSString *)fileUrl callBack:(FdCallFun)callBack;
//上传图片
- (void)startUpLoadImg:(NSString *)url params:(NSDictionary *)params fileImg:(UIImage *)fileImg callBack:(FdCallFun)callBack;
/*filePath：下载到的文件全路径，包括文件名
  isSuccess：只有succ==true&&data!=nil才算下载成功
             succ==true&&data==nil  下载进度的回调
             succ==false    下载失败
*/
- (NSURLSessionDownloadTask *)downloadFilewithURL:(NSString *)downloadUrl filePath:(NSString *)filePath withResult:(void(^)(BOOL succ,NSData *data,CGFloat percent))isSuccess;

//上传头像，进行压缩
- (void)startUpHeadImg:(NSString *)url params:(NSDictionary *)params fileImg:(UIImage *)fileImg callBack:(FdCallFun)callBack;

//上传多张图片，其中的图片有进行过压缩
- (void)startUpMulImg:(NSString *)url params:(NSDictionary *)params imgArr:(NSArray *)imgArr callBack:(FdCallFun)callBack;

//取消所有网络访问
- (void)canclePost;

@end
