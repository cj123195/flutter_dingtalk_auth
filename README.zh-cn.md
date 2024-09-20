# dingtalk_auth

一个支持你的应用进行钉钉登录认证的插件，当前仅支持 Android.

## 设置

### Android

- 在 `<project root>/android/app/src/main/AndroidManifest.xml` 文件中添加如下权限：

```xml
<uses-permission
    android:name="android.permission.INTERNET" />
<!--如果你的App targetSdkVersion>=30，请添加权限声明-->
<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />
```

- 在 `<project root>/android/app/build.gradle` 文件中设置 `minSdkVersion` 为 21.

## 安装

将以下内容添加到项目的pubspec.yaml文件中：

```yaml
dependencies:
  dingtalk_auth: ^latest
```

## 引入

```dart
import 'package:dingtalk_auth/dingtalk_auth.dart';
```

## 使用

获取 authCode:

```dart

const params = DingTalkAuthParam(
  appId: 'your app(client) id',
  redirectUrl: 'your redirect url',
);
final authCode = await DingtalkAuth.authLogin(params);
```

获取用户 accessToken：

```dart
final data = {
  "clientId": "your client id",
  "clientSecret": "your client secret",
  "code": "auth code from dingtalk",
  "grantType": "authorization_code"
};
final res = await Http().post(
  'https://api.dingtalk.com/v1.0/oauth2/userAccessToken',
  data: data,
);
```

## 相关文档

[官方Android应用授权登录接入流程](https://open.dingtalk.com/document/orgapp/android-platform-application-authorization-login-access)

## 贡献

鼓励用户积极参与其持续开发——通过修复他们遇到的任何错误，或在发现文档缺失的地方改进文档。
如果您想进行更改，请 [open a Pull Request](https://github.com/cj123195/flutter_dingtalk_auth/pull/new) --即使它只包含您正在计划的更改草案，或者再现问题的测试--我们可以从那里进一步讨论。

## License

MIT

---

> GitHub @cj123195·



