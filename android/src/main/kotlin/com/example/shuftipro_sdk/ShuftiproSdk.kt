package com.example.shuftipro_sdk

import android.app.Activity
import android.util.Log
import androidx.annotation.NonNull
import com.google.gson.Gson
import com.shutipro.sdk.Shuftipro
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import java.util.*
import kotlin.collections.HashMap

/** KycPlugin */
class ShuftiproSdk: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.example.package_sample/sendAndroid")
    channel.setMethodCallHandler(this)
  }
/*
* This method is initiated when a call from bridging class is made
* This function then modifies the data type of received parameters and calls the sdk
* The response received in this method is then forwarded to bridging class
* */
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    if (call.method == "sendRequest") {

      val shuftipro = Shuftipro.getInstance()

      val  authobj= call.argument<HashMap<String, Objects>>("AuthObj")
      val AuthKeys = JSONObject(authobj as Map<String, Any>)

      val  configobj= call.argument<HashMap<String,Objects>>("ConfigObj")
      val ConfigObject = JSONObject(configobj as Map<String, Any>)
	ConfigObject.put("platform","flutter")

      val obj = call.argument<HashMap<String,Objects>>("RequestObj")
      val gson = Gson()
      val requestObj = JSONObject(gson.toJson(obj).toString())


      if (requestObj != null)
      {
          shuftipro.shuftiproVerification(requestObj, AuthKeys, ConfigObject, activity)
          { responseSet ->

            val m2: Map<String, String> = responseSet
            result.success(JSONObject(m2).toString())
          }
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
   // TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
   // TODO("Not yet implemented")
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {
   // TODO("Not yet implemented")
  }
}
