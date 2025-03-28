//
//  ADTOpenAuthObject.h
//  ADTOpenAuthSDK
//
//  Created by zhaolei.lzl on 2020/12/22.
//  Copyright © 2020 DingTalk Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 分享SDK请求类的基类.
 */
@interface ADTBaseReq : NSObject

@property(nonatomic, copy) NSString *appId;
@property(nonatomic, copy) NSString *identifier;

- (BOOL)checkReq;
- (NSURL *)requestURL;
- (NSURL *)respURL;

+ (NSString *)dt_reqPasteBoardType;
+ (NSString *)dt_respPasteBoardType;

@end

/**
 SDK响应类的基类.
 */
@interface ADTBaseResp : NSObject <NSSecureCoding>

@property(nonatomic, assign) int64_t respCode;
@property(nonatomic, copy) NSString *respMessage;

@end

@interface ADTOpenAuthReq : ADTBaseReq


/// 创建应用时填写的回调域名，仅用于校验域名是否一致，不会跳转。
/// 注意：需要与创建应用时填写的回调域名保持一致。
///
/// 是否必填：是
@property(nonatomic, copy) NSString *redirectUrl;


///  当前只支持固定值code，授权通过后返回authCode。
///  是否必填：是
@property(nonatomic, copy) NSString *responseType;


///  应用授权作用域。授权页面显示的授权信息以应用注册时配置的为准
///  当前只支持两种输入：
///  "openid" 授权后可获得用户openid。
///  "openid corpid" 授权后可获得用户openid和登录过程中用户选择的组织corpId。
///
///  是否必填：是
@property(nonatomic, copy) NSString *scope;

/// 固定值为consent，会进入授权确认页。
/// 是否必填：是
@property(nonatomic, copy) NSString *prompt;

/// 用于保持请求和回调的状态，授权请求后原样带回给第三方。
/// 注意:该参数可用于防止csrf攻击（跨站请求伪造攻击），建议第三方带上该参数，可设置为简单的随机数加session进行校验。
///
/// 是否必填：否
@property(nonatomic, copy) NSString *state;

/// 字段值任意填写，授权登录后原样返回。用于防重放攻击字段
/// 是否必填：否
@property(nonatomic, copy) NSString *nonce;

@end

/**
 钉钉客户端处理完第三方应用的认证申请后向第三方应用回送的处理结果
 */
@interface ADTOpenAuthResp : ADTBaseResp

/**
 临时授权码
 */
@property (nonatomic, copy) NSString *authCode;

/**
 
 */
@property (nonatomic, copy) NSString *state;

@end

NS_ASSUME_NONNULL_END
