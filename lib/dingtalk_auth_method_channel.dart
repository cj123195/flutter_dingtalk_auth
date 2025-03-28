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
  Future<String?> auth(DingTalkAuthParam param) async {
    return await methodChannel.invokeMethod<String>(
      'auth',
      param.toJson(),
    );
  }

  @override
  Future<bool> registerApp(String appId, String bundleId) async {
    return await methodChannel.invokeMethod<bool>(
          'registerApp',
          {'appId': appId, 'bundleId': bundleId},
        ) ??
        false;
  }
}
