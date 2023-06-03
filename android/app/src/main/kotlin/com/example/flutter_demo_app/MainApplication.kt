package com.example.flutter_demo_app

import com.example.flutter_demo_app.R
import com.moengage.core.DataCenter
import com.moengage.core.LogLevel
import com.moengage.core.MoEngage
import com.moengage.core.config.FcmConfig
import com.moengage.core.config.InAppConfig
import com.moengage.core.config.LogConfig
import com.moengage.core.config.NotificationConfig
import com.moengage.flutter.MoEInitializer
import io.flutter.app.FlutterApplication


class MainApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()

        val builder = MoEngage.Builder(this, "U8RR6TSZPEM5EWFBCZBNJVIJ")
                .configureFcm(FcmConfig(true))
                .configureNotificationMetaData(NotificationConfig(
                        R.drawable.ic_stat_name,
                        R.drawable.download
                ))
                //.setDataCenter(DataCenter.DATA_CENTER_3)
                .configureLogs(LogConfig(LogLevel.VERBOSE, true))

        MoEInitializer.initialiseDefaultInstance(this, builder)

    }
}