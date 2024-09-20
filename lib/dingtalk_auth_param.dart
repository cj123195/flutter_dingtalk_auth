/// 应用授权作用域
enum DingTalkAuthScope {
  /// 授权后可获得用户oepnid
  openid('openid'),

  /// 授权后可获得用户openid和登录过程中用户选择的组织corpId
  openidCorpid('openid%20corpid');

  const DingTalkAuthScope(this.value);

  final String value;
}

/// 钉钉登录认证参数
class DingTalkAuthParam {
  const DingTalkAuthParam({
    required this.appId,
    required this.redirectUrl,
    this.state = '',
    this.nonce = '',
    this.scope = DingTalkAuthScope.openidCorpid,
  });

  /// 钉钉开放平台应用标识。
  final String appId;

  /// 创建应用时填写的回调域名，仅用于校验域名是否一致，不会跳转。
  ///
  /// 需要与创建应用时填写的回调域名保持一致。
  final String redirectUrl;

  /// 用于保持请求和回调的状态，授权请求后原样带回给第三方。
  ///
  /// 该参数可用于防止csrf攻击（跨站请求伪造攻击），建议第三方带上该参数，可设置为简单的随机数
  /// 加 session 进行校验。
  final String state;

  /// 字段值任意填写，授权登录后原样返回。
  final String nonce;

  /// 应用授权作用域。授权页面显示的授权信息以应用注册时配置的为准
  ///
  /// 默认值为 [DingTalkAuthScope.openidCorpid]
  final DingTalkAuthScope scope;

  /// 当前只支持固定值code，授权通过后返回authCode。
  final String responseType = 'code';

  /// 固定值为consent，会进入授权确认页。
  final String prompt = 'consent';
  final String altSignature = '';

  Map<String, String> toJson() {
    return {
      'appId': appId,
      'redirectUri': redirectUrl,
      'state': state,
      'nonce': nonce,
      'scope': scope.value,
      'responseType': responseType,
      'prompt': prompt,
      'altSignature': altSignature,
    };
  }
}
