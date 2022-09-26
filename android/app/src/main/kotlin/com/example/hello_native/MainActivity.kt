package com.example.hello_native

import androidx.annotation.NonNull

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  private val CHANNEL = "com.example.hello_native/channel"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if (call.method == "stepper") {
        val dataMap = HashMap<String, String>()
        dataMap["Select campaign settings"] = "Select campaign settings add some text from native, yeay this works"
        dataMap["Create an ad group"] = "Create an ad group add some text from native, wow this works"
        dataMap["Create an ad"] = "Create an ad add some text from native, amazing this works"
        result.success(dataMap)
      } else {
        result.notImplemented()
      }
    }
  }
}
