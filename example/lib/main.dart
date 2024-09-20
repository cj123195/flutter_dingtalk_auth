import 'dart:async';

import 'package:dingtalk_auth/dingtalk_auth.dart';
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

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> authLogin() async {
    String authCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      authCode = await DingtalkAuth.authLogin(
            const DingTalkAuthParam(appId: '', redirectUrl: ''),
          ) ??
          'Unknown platform version';
    } on PlatformException {
      authCode = 'Failed to get auth code.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _authCode = authCode;
    });
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
