# dingtalk_auth

This is a plugin that supports DingTalk authentication for your application. Currently only supports
Android.

## Settings

### Android

- Add the following permissions to your `AndroidManifest.xml`, located
  in `<project root>/android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission
    android:name="android.permission.INTERNET" />
<!--If your App targetSdkVersion>=30, please add a permission statement-->
<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />
```

- Set `minSdkVersion` to 21 in `<project root>/android/app/build.gradle`.

### iOS

1. 在 Info.plist 中添加以下配置：

```xml
<!-- 配置 URL Scheme -->
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>dingtalk</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>YOUR_APP_ID</string>
			</array>
		</dict>
	</array>

<!-- 配置白名单 -->
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>dingtalk</string>
    <string>dingtalk-open</string>
    <string>dingtalk-sso</string>
</array>
```
2. 确保项目的 Bundle ID 与钉钉开放平台配置的一致
3.  运行 pod install 安装依赖

## Installing

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  dingtalk_auth: ^latest
```

## Import

```dart
import 'package:dingtalk_auth/dingtalk_auth.dart';
```

## Usage

Register your application(iOS Only):

```dart
await DingtalkAuth.registerApp(
  appId: 'your app id',
  bundleId: 'your bundle id', // iOS 平台必填，Android 可传空
);
```

Get auth code:

```dart

const params = DingTalkAuthParam(
  appId: 'your app(client) id',
  redirectUrl: 'your redirect url',
);
final authCode = await DingtalkAuth.authLogin(params);
```

Get user access token:

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

## Related

[Official Android application authorization login access process](https://open.dingtalk.com/document/orgapp/android-platform-application-authorization-login-access)
[Official iOS application authorization login access process](https://open.dingtalk.com/document/orgapp/mini-app-procedures-for-authorized-logon-to-ios-applications)

## Contribution

Users are encouraged to become active participants in its continued development — by fixing any bugs that they encounter, or by improving the documentation wherever it’s found to be lacking.

If you wish to make a change, [open a Pull Request](https://github.com/cj123195/flutter_dingtalk_auth/pull/new) — even if it just contains a draft of the changes you’re planning, or a test that reproduces an issue — and we can discuss it further from there.

## License

MIT

---

> GitHub @cj123195·



