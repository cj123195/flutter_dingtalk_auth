//
//  ADTOpenAuthAPI.h
//  ADTOpenAuthSDK
//
//  Created by zhaolei.lzl on 2017/10/24.
//  Copyright © 2017 DingTalk Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ADTOpenAuthEnvironment) {
    ADTOpenAuthEnvironmentRelease       = 0,    // 线上环境,默认值
    ADTOpenAuthEnvironmentPreRelease    = 1,    // 预发环境
    ADTOpenAuthEnvironmentDev           = 2,    // 开发环境
};

typedef NS_ENUM(NSUInteger, ADTOpenAuthResponseCode) {
    ADTOpenAuthResponseCodeOK           = 0,    //
    ADTOpenAuthResponseCodeUserCancel   = -2,   // 用户在授权过程中主动取消
};

@class ADTBaseReq;
@class ADTBaseResp;

/**
 接受并处理来自钉钉的事件消息.
 
 钉钉向第三方APP发送事件期间, 钉钉界面会向切换到第三方APP. ADTOpenAuthAPIDelegate 会在 +[ADTOpenAuthAPI handleOpenURL:delegate:] 中触发.
 */
@protocol ADTOpenAuthAPIDelegate <NSObject>
@optional

/**
 收到一个来自钉钉的请求, 第三方APP处理完成后要调用 +[ADTOpenAuthAPI sendResp:withReq:] 将处理结果返回给钉钉.
 
 @param req 来自钉钉具体的请求.
 */
- (void)onReq:(ADTBaseReq *)req;

/**
 第三方APP使用 +[ADTOpenAuthAPI sendReq:] 向钉钉发送消息后, 钉钉会处理完请求后会回调该接口.
 
 @param resp 来自钉钉具体的响应.
 */
- (void)onResp:(ADTBaseResp *)resp;
@end


@interface ADTOpenAuthAPI : NSObject

/**
 
 第三方应用程序需要在程序启动时调用. @note 请在主线程中调用此方法.
 
 @param appId 在钉钉开放平台申请的应用ID.
 @param identifier 在钉钉开放平台申请的应用BundleID.
 
 @return YES 注册成功. NO 注册失败.
 */
+ (BOOL)registerApp:(NSString *)appId
         identifier:(NSString *)identifier;

+ (void)setEnvironment:(ADTOpenAuthEnvironment)environment;

/**
 检测设备是否安装了钉钉客户端.
 
 @return YES 设备安装了钉钉客户端. NO 设备没有安装钉钉客户端.
 */
+ (BOOL)isDingTalkInstalled;


/**
 发送登录请求
 
 @param req 封装请求的对象. 支持的类型:ADTOpenAuthResp.
 @param viewController 当H5授权时，会使用此viewController做present一个网页；如果传nil，会导致无法打开授权H5网页.

 @return YES 请求发送成功. NO 请求发送失败.
 */
+ (BOOL)sendReq:(ADTBaseReq *)req onViewController:(UIViewController *)viewController;

+ (void)sendResp:(ADTBaseResp *)resp
         withReq:(ADTBaseReq *)req;

// may be private
+ (NSString *)appId;
+ (NSString *)identifier;
+ (ADTOpenAuthEnvironment)environment;
// 钉钉外跳的额外scheme(不是AppId)
@property (nonatomic, class) NSString *tpScheme;

/**
 第三方应用处理钉钉回调的接口.
 
 第三方应用需要在 -[UIApplicationDelegate application:openURL:sourceApplication:annotation:] 或者 -[UIApplicationDelegate application:openURL:options:] 中调用该方法.

 @param url 钉钉给第三方回调的URL.
 @param delegate 实现DTOpenAPIDelegate的对象, 通过ADTOpenAuthAPIDelegate处理钉钉的回调结果.
 
 @return YES 回调处理成功. NO 回调处理失败.
 */
+ (BOOL)handleOpenURL:(NSURL *)URL delegate:(id<ADTOpenAuthAPIDelegate>)delegate;

/// 移除所有item data
+ (void)removeAllItemData;
/// 保存URL里的数据
+ (void)storeItemDataWithURL:(NSURL *)URL;

@end

// may be private
FOUNDATION_EXTERN NSString * const kADTDingTalkOpenAuthPath;
FOUNDATION_EXTERN NSString * const kADTDingTalkOpenAuthURLScheme;
FOUNDATION_EXTERN NSString * const kADTDingTalkOpenAuthURL2Scheme;

FOUNDATION_EXTERN NSString * const kADTOpenAuthRedirectQueryKeyAuthCode;
FOUNDATION_EXTERN NSString * const kADTOpenAuthRedirectQueryKeyState;
FOUNDATION_EXTERN NSString * const kADTOpenAuthRedirectQueryKeyError;


FOUNDATION_EXTERN NSString * const kADTOpenAuthRequestQueryKeyAppId;
FOUNDATION_EXTERN NSString * const kADTOpenAuthRequestQueryKeyAuthUrl;

FOUNDATION_EXTERN NSString * const kADTOpenAuthResponseMessageUserCancel;
