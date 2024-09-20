package com.cj.dingtalk_auth

import android.content.Intent
import android.text.TextUtils
import android.util.Log
import com.android.dingtalk.openauth.utils.DDAuthConstant
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

object AuthResponseHandler {
    private var channel: MethodChannel? = null
    private var result: Result? = null

    fun setMethodChannelAndResult(channel: MethodChannel, result: Result) {
        AuthResponseHandler.channel = channel
        AuthResponseHandler.result = result
    }

    fun handleAuthLoginResult(intent: Intent) {
        val authCode = intent.getStringExtra(DDAuthConstant.CALLBACK_EXTRA_AUTH_CODE)
        val state = intent.getStringExtra(DDAuthConstant.CALLBACK_EXTRA_STATE)
        val error = intent.getStringExtra(DDAuthConstant.CALLBACK_EXTRA_ERROR)

        if(result != null) {
            if (!TextUtils.isEmpty(authCode)) {
                result!!.success(authCode)
            } else {
                result!!.error("", error, state)
            }
            channel = null
            result = null
        }
    }
}