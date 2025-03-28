//
//  ADTOpenAuthUtils.h
//  ADTOpenAuthSDK
//
//  Created by zhaolei.lzl on 2020/12/24.
//  Copyright © 2020 DingTalk Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADTOpenAuthUtils : NSObject

+ (NSString *)urlEncode:(NSString *)encodeStr;

+ (NSString *)trimStr:(NSString *)str;

+ (NSString *)absoluteStringWithScheme:(NSString *)scheme
                                  path:(NSString *)path
                                params:(NSDictionary *)params;

+ (NSString *)reqPasteBoardTypeWithAppId:(NSString *)appId;
+ (NSString *)respPasteBoardTypeWithAppId:(NSString *)appId;

+ (BOOL)addItemData:(NSData *)itemData pasteboardType:(NSString *)pasteboardType;
+ (NSData *)itemDataForPasteboardType:(NSString *)pasteboardType;

@end

NS_ASSUME_NONNULL_END
