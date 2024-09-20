import 'package:dingtalk_auth/dingtalk_auth_method_channel.dart';
import 'package:dingtalk_auth/dingtalk_auth_param.dart';
import 'package:dingtalk_auth/dingtalk_auth_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDingtalkAuthPlatform
    with MockPlatformInterfaceMixin
    implements DingtalkAuthPlatform {
  @override
  Future<String?> authLogin(DingTalkAuthParam param) => Future.value('123456');
}

void main() {
  final DingtalkAuthPlatform initialPlatform = DingtalkAuthPlatform.instance;

  test('$MethodChannelDingtalkAuth is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDingtalkAuth>());
  });
}
