import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dingtalk_auth_method_channel.dart';
import 'dingtalk_auth_param.dart';

abstract class DingtalkAuthPlatform extends PlatformInterface {
  /// Constructs a DingtalkAuthPlatform.
  DingtalkAuthPlatform() : super(token: _token);

  static final Object _token = Object();

  static DingtalkAuthPlatform _instance = MethodChannelDingtalkAuth();

  /// The default instance of [DingtalkAuthPlatform] to use.
  ///
  /// Defaults to [MethodChannelDingtalkAuth].
  static DingtalkAuthPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DingtalkAuthPlatform] when
  /// they register themselves.
  static set instance(DingtalkAuthPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> authLogin(DingTalkAuthParam param) {
    throw UnimplementedError('auth() has not been implemented.');
  }
}
