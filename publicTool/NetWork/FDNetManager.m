//
//  FDNetManager.m
//  Runner
//
//  Created by  Tmac on 16/3/11.
//  Copyright © 2016年 Janson. All rights reserved.
//

#import "FDNetManager.h"

@interface FDNetManager()
{
    NSOperationQueue *queue;
}

@property(nonatomic) AFHTTPSessionManager *manager;
@end

@implementation FDNetManager

+ (FDNetManager *)shareInstance
{
    static FDNetManager *opt;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        opt = [[FDNetManager alloc] init];
    });
    return opt;
}

- (instancetype)init
{
    if(self=[super init])
    {
        queue = [[NSOperationQueue alloc] init];
        [queue setMaxConcurrentOperationCount:4];
        [self reachNetWorkWithBlock:nil];
        
    }
    
    return self;
}

- (AFHTTPSessionManager *)manager
{
    if(!_manager)
    {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];   //二进制格式
        AFSecurityPolicy* policy = [AFSecurityPolicy defaultPolicy];  //使用默认的设置
        [policy setAllowInvalidCertificates:YES];
        [policy setValidatesDomainName:NO];
        manager.securityPolicy = policy;
        manager.requestSerializer.timeoutInterval = 25;
        
        _manager = manager;
    }
    
    return _manager;
}

- (BOOL)isReachable
{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}
#pragma mark - 检测网络连接
- (void)reachNetWorkWithBlock:(void (^)(BOOL blean))block;
{
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //NSLog(@"%d", status);
        BOOL isconnect = NO;
        if (status >0) {
            isconnect = YES;
        }
        if(block)
            block(isconnect);
    }];
}

- (void)canclePost
{
    if(queue)
    {
        [queue cancelAllOperations];
    }
}

- (NSURLSessionDownloadTask *)downloadFilewithURL:(NSString *)downloadUrl filePath:(NSString *)_filePath withResult:(void(^)(BOOL succ,NSData *data,CGFloat percent))isSuccess
{

    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:downloadUrl]];
    
    NSURLSessionDownloadTask *_task=[session downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //下载进度
        //NSLog(@"%f",downloadProgress.fractionCompleted);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(isSuccess)
                isSuccess(YES,nil,downloadProgress.fractionCompleted);
        });
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //下载到哪个文件夹
        NSString *cachePath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        
        NSString *fileName=[cachePath stringByAppendingPathComponent:response.suggestedFilename];
        if(_filePath!=nil)
            fileName = _filePath;
        return [NSURL fileURLWithPath:fileName];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if(!error)
        {
            //下载完成了
            NSLog(@"下载完成 %@",filePath);
            NSData *data = [NSData dataWithContentsOfURL:filePath];
            if(isSuccess)
                isSuccess(YES,data,1.0);
        }
        else
            if(isSuccess)
                isSuccess(NO,nil,1.0);
        
    }];
    
    [_task resume];
    return _task;
}

- (void)startPost:(NSString *)serverUrl params:(NSDictionary *)params callBack:(FdCallFun)callBack
{
    
    [self.manager POST:serverUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"+>>>>%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:nil];

            if (!jsonObject)
            {
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                if (callBack)
                {
                    callBack(str,YES);
                }
    
            }
            else
            {
                if (callBack)
                {
                    callBack(jsonObject,YES);
                }

            }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *str = [NSString stringWithFormat:@"请求失败：\n%@ 错误信息：\n%@",error.description,error.userInfo [NSLocalizedDescriptionKey]];
        if (callBack)
        {
            callBack(str,NO);
        }

    }];
}


- (void)startUpLoadFile:(NSString *)url fileType:(int)fileType params:(NSDictionary *)params fileUrl:(NSString *)fileUrl callBack:(FdCallFun)callBack
{
    NSString *fileName = @"uploadfile.jpg";
    NSString *mimeType = @"image/jpeg";
    if(fileType == NET_FILE_AUDIO_PCM)
    {
        fileName = @"uploadfile.pcm";
        mimeType = @"audio/basic";
    }
    if(fileType == NET_FILE_VCf)
    {
        fileName = @"card.vcf";
        mimeType = @"text/x-vcard";
    }
    
    if (fileUrl!=nil && fileUrl.length>0)
    {
        NSURL *filePath = [NSURL fileURLWithPath:fileUrl];
        
        
        [self.manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSError *error;

            if ( [formData appendPartWithFileURL:filePath name:@"file" fileName:fileName mimeType:mimeType error:&error] == NO)
            {
                NSLog(@"Append part failed with error: %@", error);
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"+>>>>>>%@",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:nil];
            if (callBack)
            {
                if(jsonObject)
                    callBack(jsonObject,YES);
                else
                {
                    NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSLog(@"非JSON格式：%@", str);
                    callBack(responseObject,YES);
                }
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (callBack)
            {
                callBack(error.domain,NO);
            }

            NSLog(@"失败Error: %@", error);
        }];
    }
    else
    {
        if (callBack)
        {
            callBack(@"fileUrl error!!",NO);
        }
    }
}

- (void)startUpHeadImg:(NSString *)url params:(NSDictionary *)params fileImg:(UIImage *)fileImg callBack:(FdCallFun)callBack
{
    if(fileImg==nil)
    {
        if(callBack)
            callBack(@"",NO);
        return;
    }
    
    UIImage *image = [PublicFunction getImage:fileImg width:80 height:80];
    
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil)
    {
        //0.6为压缩系数
        data = UIImageJPEGRepresentation(image, 0.6);
    }
    else
    {
        data = UIImagePNGRepresentation(image);
    }
    
    //图片重命名
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    NSString *filePath = [cachePath stringByAppendingFormat:@"/showImage.png"];
    
    //图片保存路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:filePath contents:data attributes:nil];
    
    [self startUpLoadFile:url fileType:NET_FILE_IMAGE params:params fileUrl:filePath callBack:^(id result, BOOL succ) {
        
        if(callBack)
            callBack(result,succ);
    }];
}

- (void)startUpMulImg:(NSString *)url params:(NSDictionary *)params imgArr:(NSArray *)imgArr callBack:(FdCallFun)callBack
{
    NSMutableArray *dataArr = [[NSMutableArray alloc] initWithCapacity:10];
    for(UIImage *img in imgArr)
    {
        NSData *data = [XlabTools zipImageWithImage:img withMaxSize:200];
        if(data)
            [dataArr addObject:data];
    }
    
    if(dataArr.count==0)
    {
        if(callBack)
            callBack(@"",YES);
    }
    
    __block BOOL succ = NO;
    __block NSString *errStr = @"";
    __block int num = 0;
    NSString *mimeType = @"image/jpeg";
    for(NSData *imgData in dataArr)
    {
        [self.manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imgData name:@"file" fileName:[NSString stringWithFormat:@"image%d.jpg",num] mimeType:mimeType];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"+>>>>>%lld",uploadProgress.completedUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
                succ = YES;
                NSLog(@"result = %d image&%d",succ,++num);
                if(num==dataArr.count)
                {
                    id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:nil];
                    if(callBack)
                        callBack(jsonObject,YES);
                }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            succ = NO;
            errStr = error.domain;
            NSLog(@"result = %@ image&%d",errStr,++num);
            if(num==dataArr.count)
            {
                if(callBack)
                    callBack(@"",YES);
            }

        }];
    }
}

- (void)startUpLoadImg:(NSString *)url params:(NSDictionary *)params fileImg:(UIImage *)fileImg callBack:(FdCallFun)callBack
{
    UIImage *image = fileImg;
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil)
    {
        //0.6为压缩系数
        data = UIImageJPEGRepresentation(image, 0.8);
    }
    else
    {
        data = UIImagePNGRepresentation(image);
    }
    
    if(!data)
        return;
    
    [self.manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"+>>>>>%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:nil];
        if (callBack)
        {
            if(jsonObject)
                callBack(jsonObject,YES);
            else
            {
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"非JSON格式：%@", str);
                callBack(responseObject,YES);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (callBack)
        {
            callBack(error.domain,NO);
        }
        
        NSLog(@"Error: %@", error);
        
    }];
}
@end
