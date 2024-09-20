import 'package:dingtalk_auth/dingtalk_auth_param.dart';

import 'dingtalk_auth_platform_interface.dart';

export 'package:dingtalk_auth/dingtalk_auth_param.dart';

class DingtalkAuth {
  static Future<String?> authLogin(DingTalkAuthParam param) async {
    return await DingtalkAuthPlatform.instance.authLogin(param);
  }
}
