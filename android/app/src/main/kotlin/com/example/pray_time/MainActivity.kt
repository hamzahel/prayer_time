package com.example.pray_time

import android.content.Context
import android.content.Intent
import android.os.PowerManager
import android.util.Log
import android.view.WindowManager
import androidx.annotation.NonNull
import dev.fluttercommunity.plus.androidalarmmanager.AlarmBroadcastReceiver
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "example.com/channel_alarm").setMethodCallHandler {
                call, result ->
            if(call.method == "launchScreen") {
                Log.d("INFO", "you invoke method")
//                AlarmBroadcastReceiver.wakeLock = powerManager.newWakeLock(
//                    WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON or
//                            PowerManager.ACQUIRE_CAUSES_WAKEUP or
//                            PowerManager.ON_AFTER_RELEASE, "My wakelock"
//                )
                val pm = context.getSystemService(Context.POWER_SERVICE) as PowerManager
//                val wl = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "YOUR TAG")
//                wl.acquire()

                // Put here YOUR code.

                // Put here YOUR code.
                val intent1 = Intent(context, FlutterActivity::class.java)

                intent1.flags = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT or
                        Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
                intent1.action = Intent.ACTION_RUN
                intent1.putExtra("route", "/Notification")
                context.startActivity(intent1)
//                wl.release()
            }
            else {
                result.notImplemented()
            }
        }
    }
}

