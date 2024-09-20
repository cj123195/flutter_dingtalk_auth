package com.cj.dingtalk_auth.ddauth

import android.app.Activity
import android.os.Bundle
import com.cj.dingtalk_auth.AuthResponseHandler


class DDAuthActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        AuthResponseHandler.handleAuthLoginResult(intent = intent)

        finish()
    }
}