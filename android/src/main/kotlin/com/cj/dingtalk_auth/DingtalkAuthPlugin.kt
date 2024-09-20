package com.cj.dingtalk_auth

import android.content.Context
import android.content.Intent
import android.util.Log
import com.android.dingtalk.openauth.AuthLoginParam.AuthLoginParamBuilder
import com.android.dingtalk.openauth.DDAuthApiFactory
import com.android.dingtalk.openauth.utils.DDAuthConstant

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** DingtalkAuthPlugin */
class DingtalkAuthPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "dingtalk_auth")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        AuthResponseHandler.setMethodChannelAndResult(channel, result)
        if (call.method == "authLogin") {
            val args = (call.arguments as HashMap<*, *>)
            val builder = AuthLoginParamBuilder.newBuilder()
            builder.appId(args["appId"] as String)
            builder.redirectUri(args["redirectUri"] as String)
            builder.scope(args["scope"] as String)
            builder.responseType("code")
            builder.nonce(args["nonce"] as String)
            builder.state(args["state"] as String)
            val authApi = DDAuthApiFactory.createDDAuthApi(context, builder.build())
            authApi.authLogin()
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
