import 'dart:async';

import 'package:dingtalk_auth/dingtalk_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _authCode = 'Tap Auth button to get auth code';

  static const String _clientId = '';
  static const String _clientSecret = '';
  static const String _redirectUrl = '';
  static const String _grantType = 'authorization_code';

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> authLogin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      _authCode = await DingtalkAuth.authLogin(
            const DingTalkAuthParam(
              appId: _clientId,
              redirectUrl: _redirectUrl,
            ),
          ) ??
          'Unknown platform version';

      getToken();
    } on PlatformException {
      _authCode = 'Failed to get auth code.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  // Get access_token by auth code.
  Future<void> getToken() async {
    try {
      final res = await Dio().post(
        'https://api.dingtalk.com/v1.0/oauth2/userAccessToken',
        data: {
          "clientId": _clientId,
          "clientSecret": _clientSecret,
          "code": _authCode,
          "grantType": _grantType,
        },
      );
      getUserInfo(res.data!['accessToken']);
    } on DioException catch (e) {
      debugPrint(e.message ?? '');
    }
  }

  // Get user info by access_token.
  Future<void> getUserInfo(String token) async {
    try {
      final res = await Dio().get(
        'https://api.dingtalk.com/v1.0/contact/users/me',
        options: Options(
          headers: {'x-acs-dingtalk-access-token': token},
        ),
      );
      debugPrint(res.data.toString());
    } on DioException catch (e) {
      debugPrint(e.message ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Auth code: $_authCode\n'),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(
            onPressed: authLogin,
            child: const Text('Auth'),
          ),
        ),
      ),
    );
  }
}
