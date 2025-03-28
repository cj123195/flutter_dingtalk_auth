import 'package:dingtalk_auth/dingtalk_auth_param.dart';
import 'dingtalk_auth_platform_interface.dart';

export 'package:dingtalk_auth/dingtalk_auth_param.dart';

/// 钉钉认证插件
///
/// 提供钉钉认证相关功能，包括应用注册和授权登录
class DingtalkAuth {
  /// 发起钉钉授权登录
  ///
  /// [param] 授权参数，包含以下字段：
  /// - redirectUrl: 授权回调地址
  /// - scope: 授权范围
  /// - prompt: 授权页面提示
  /// - state: 授权状态值，用于防止CSRF攻击
  ///
  /// 返回授权结果，成功时返回授权码，失败时返回 null
  ///
  /// 示例:
  /// ```dart
  /// final param = DingTalkAuthParam(
  ///   redirectUrl: 'your_redirect_url',
  ///   scope: 'your_scope',
  ///   prompt: 'your_prompt',
  ///   state: 'your_state'
  /// );
  /// final result = await DingtalkAuth.authLogin(param);
  /// ```
  static Future<String?> auth(DingTalkAuthParam param) async {
    return await DingtalkAuthPlatform.instance.auth(param);
  }

  /// 注册钉钉应用
  ///
  /// 仅支持 iOS 平台。
  ///
  /// [appId] 钉钉开放平台申请的应用 ID
  /// [bundleId] iOS 应用的 Bundle ID
  ///
  /// 返回注册结果，true 表示注册成功，false 表示注册失败
  ///
  /// 示例:
  /// ```dart
  /// final success = await DingtalkAuth.registerApp(
  ///   'your_app_id',
  ///   'your_bundle_id'
  /// );
  /// ```
  static Future<bool> registerApp(String appId, String bundleId) async {
    return await DingtalkAuthPlatform.instance.registerApp(appId, bundleId);
  }
}
