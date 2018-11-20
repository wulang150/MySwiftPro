//
//  NetManager.h
//  MyProject
//
//  Created by  Tmac on 2017/7/20.
//  Copyright © 2017年 Tmac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject

//设备记录数据的上传
+ (void)uploadDeviceRecord:(NSString *)filepath callBack:(void(^)(BOOL succ,NSString *ret))callBack;

//设备报告与签名的上传
+ (void)uploadsignReport:(NSString *)file1 file2:(NSString *)file2 callBack:(void(^)(BOOL succ,NSString *ret))callBack;

//设备UDI数据的上传
+ (void)uploadUDI:(NSString *)file callBack:(void(^)(BOOL succ,NSString *ret))callBack;

//设备ASN数据的上传
+ (void)uploadASN:(NSString *)filepath callBack:(void(^)(BOOL succ,NSString *ret))callBack;
@end
