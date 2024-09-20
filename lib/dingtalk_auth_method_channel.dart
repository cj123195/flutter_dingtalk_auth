import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dingtalk_auth_param.dart';
import 'dingtalk_auth_platform_interface.dart';

/// An implementation of [DingtalkAuthPlatform] that uses method channels.
class MethodChannelDingtalkAuth extends DingtalkAuthPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dingtalk_auth');

  @override
  Future<String?> authLogin(DingTalkAuthParam param) async {
    return await methodChannel.invokeMethod<String>(
      'authLogin',
      param.toJson(),
    );
  }
}
