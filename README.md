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

## Contribution

Users are encouraged to become active participants in its continued development — by fixing any bugs that they encounter, or by improving the documentation wherever it’s found to be lacking.

If you wish to make a change, [open a Pull Request](https://github.com/cj123195/flutter_dingtalk_auth/pull/new) — even if it just contains a draft of the changes you’re planning, or a test that reproduces an issue — and we can discuss it further from there.

## License

MIT

---

> GitHub @cj123195·



