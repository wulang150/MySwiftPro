//
//  XlabTools.h
//  ColorBand
//
//  Created by fly on 15/5/12.
//  Copyright (c) 2015年 com.fenda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class MBProgressHUD;
@interface XlabTools : NSObject
{
    MBProgressHUD *_loadingView;
    NSUInteger _loadingCount;
}

#define SINGLETON_SYNTHE \
+ (id)sharedInstance\
{\
static id shared = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken,\
^{\
shared = [[self alloc]init];\
});\
return shared;\
}



#define SINGLETON + (id)sharedInstance;

SINGLETON


- (void)startLoadingInView:(UIView *)view;
- (void)startLoadingInView:(UIView *)view withmessage:(NSString *)message;
- (void)stopLoading;


//检测是否有网络
+(BOOL)isNetConnect;

//判断当前时间的制式
+(BOOL)getTimeSys;
//判断当前是上下午
+(NSString *)getAmOrPm;
//持久化数据
+(void)setStringValue:(id)value defaultKey:(NSString *)defaultKey;
//获取持久化的数据
+(id)getStringValueFromKey:(NSString *)defaultKey;
//持久化BOOL状态值
+(void)setBoolState:(BOOL)loginState defaultKey:(NSString *)defaultKey;
+(BOOL)getBoolState:(NSString *)defaultKey;

//移除userDefault
+ (void)removeNsuserDefault:(NSString *)defaultKey;

//查看所有的userdefault的值
+ (void)showAllUserDefaultsData;
/**
 *  清除所有的存储本地的数据
 */
+ (void)clearAllUserDefaultsData;

//按首字母排序并拼接成字符串
+ (NSString *)getStrFromDic:(NSDictionary *)dic;
// 是否wifi
+ (BOOL) IsEnableWIFI;
// 是否3G
+ (BOOL) IsEnable3G;

+ (void)setStatusBarBlack:(UIViewController *)viewController;
+(void)pullView:(UIView *)view;
+(BOOL)isIOS7;
+(BOOL)isRetinaDisplay;
+(int)getSystemMainVersion;
+(NSString *)getHumanString:(int)index;

//装字符串的数组,对比
+ (BOOL)isEqueltheStringArray:(NSMutableArray *)arr1 withOtherStringArray:(NSMutableArray *)arr2;

+(BOOL)isChinese;
+(NSString*)currentLanguage;
+(NSString *)deviceName;

+(NSUUID*)uuid;
+(NSString*)UUIDString;


+(NSData*)hexStringToNSData:(NSString *)command;
+(NSData*) bytesFromHexString:(NSString *)aString;

+ (NSString *)getPicturefromCaches;

/*********************By Fly****************/
/**
 *  处理字符串 type为1表示把hourStr处理成X时X分，type为0处理成两个的,type为1处理单个。
 *
 *  @param SourceStr 需要处理de字符串
 *  @param unitArray 单位数组
 *  @param attriArry 参数信息
 *  @param type      处理数据的格式
 *
 *  @return 返回处理好的数据
 */
+ (NSAttributedString *)getModifyGoodFrom:(NSString *)SourceStr withUnit:(NSArray *)unitArray withAttributArr:(NSArray *)attriArry type:(int)type;

// 等比例压缩高清 kBit 压缩后的数据大小
+ (NSData *)zipImageWithImage:(UIImage *)image withMaxSize:(NSInteger)kBit;
//图片等比压缩处理500*500
+ (UIImage *)scaleImage:(UIImage *)image tosize:(CGSize)size;
//根据图片大小，适当进行图片压缩
+(NSData *)imageData:(UIImage *)myimage;

//获取字段长度
+ (CGSize)getSizeFromString:(NSString *)string withFont:(CGFloat)floatNumber wid:(CGFloat)wid;

+ (NSMutableString *)getArrayToString:(NSMutableArray *)array;
+ (NSMutableArray *)getArrayFromString:(NSString *)string;
//获取url链接字符串中的参数
+ (NSString *) jiexi:(NSString *)CS webaddress:(NSString *)webaddress;
/**
 *  int类型的数据转换成NSData
 *
 *  @param operatetype 需要转换的int类型
 *
 *  @return 返回转换好的NSData类型
 */
+(NSData *)intTochar:(int)operatetype;

//计算CRC值（128）
+ (uint16_t)creatCRCWith:(NSData *)data withLenth:(NSInteger)lenth;

// 随机数（8~20位长，允许0-9数字和a-zA-Z字母），用于关联所生成的验证码图形信息。
+ (NSString*) randomWithLengh:(int)randomLength;

//两个字节的数据移位操作
+ (UInt16)NSDataToUInt16:(NSData*)data;
//四个字节的数据移位操作
+ (UInt32) NSDataToUInt32:(NSData *)data;

+ (int)timeFromDateString:(NSString *)dateString withType:(int)type;
//将十进制转化为二进制,设置返回NSString长度
+ (NSString *)decimalTOBinary:(uint16_t)tmpid backLength:(int)length;

//生成crc值用到的两个方法
- (void)initCrcTable;
- (uint32_t)crc32WithData:(NSData *)data;

/****************** by Janson ************************/

//过滤字典中空的值
+ (NSDictionary *)fitterDicNullValue:(NSDictionary *)dic;
// 模型转字典
+ (NSDictionary *)modelConvertToDictionary:(id)model;
//json字符串转类型
+ (id)jsonConvertToId:(NSString *)json;
//获取模型属性数组
+ (NSArray *)getPropertiesFromModel:(id)model;
// 字典转成 json 字符串
+ (NSString *)dictionaryConvertToJSONObjectStr:(id)dic;
//url编码
+(NSString*)UrlencodeString:(NSString*)unencodedString;
//数组按给定序号重新排列
+(void )array:(NSMutableArray *)mArray OrderByArray:(NSArray <NSNumber *>*)array;

/********************* by  zhuochunsheng****************/
/**
 *  UIColor 转UIImage
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
+(UIImage*)ChangeUIColorToUIImage: (UIColor*) color;

/**
 *  UIImage转UIColor
 *
 *  @param pngName <#pngName description#>
 *
 *  @return <#return value description#>
 */
+(UIColor *)ChangeUIImageToUIColor:(NSString *)pngName;

/**
 *  UIView转UIImage
 *
 *  @param v <#v description#>
 *
 *  @return <#return value description#>
 */
+(UIImage*)convertViewToImage:(UIView*)v;

/**
 *  根据给定的图片，从其指定区域截取一张新的图片
 *
 *  @param img <#img description#>
 *
 *  @return <#return value description#>
 */
+(UIImage *)getImageFromImage:(UIImage *)img;

/**
 *  十六进制转换为普通字符串的。
 *
 *  @param hexString <#hexString description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)stringFromHexString:(NSString *)hexString;

/**
 *  普通字符串转换为十六进制的。
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)hexStringFromString:(NSString *)string;

/**
 *  颜色转换 IOS中十六进制的颜色转换为UIColor
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

/**
 *  绘图
 *
 *  @param colorName <#colorName description#>
 *
 *  @return <#return value description#>
 */
+(UIImage *)drawcolorInImage:(NSString *)colorName;

/**
 *  图片缩放到指定大小尺寸
 *
 *  @param img  <#img description#>
 *  @param size <#size description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

+ (void) redirectConsoleLogToDocumentFolder;

//获取网络状态
+ (NSString *)getNetWorkStates;
//获取当前的UIViewController
+ (UIViewController *)getCurrentVC;
@end
