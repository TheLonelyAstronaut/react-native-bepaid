package com.reactnativebepaid

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import com.facebook.react.bridge.*
import java.io.Serializable
import java.lang.Error

class BepaidModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext), ActivityEventListener {
    private lateinit var reactPromise: Promise
    private lateinit var paymentActivity: BepaidActivity
    private var context = reactApplicationContext
		private var amount: Double = 0.0;

    override fun getName(): String {
        return "BePaid"
    }

    @ReactMethod
    fun processPayment(promise: Promise) {
        reactPromise = promise;
        val intent = Intent(context, BepaidActivity::class.java)
        context.addActivityEventListener(this);
				intent.putExtra("amount", amount);

        if(intent.resolveActivity(context.packageManager) != null) {
            intent.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
            context.startActivityForResult(intent, 100, null);
        }
    }

		@ReactMethod
		fun setAmount(amount: Double) {
				this.amount = amount;
		}

    override fun onNewIntent(intent: Intent?) {}

    override fun onActivityResult(activity: Activity?, requestCode: Int, resultCode: Int, data: Intent?) {
        if(resultCode == 100) {
						val result: WritableMap = Arguments.createMap();
						result.putString("result", data?.getStringExtra("result"));
						result.putString("error", data?.getStringExtra("error"));
						result.putString("token", data?.getStringExtra("token"));
						result.putInt("responseCode", data?.getIntExtra("responseCode", 0) as Int);
						reactPromise.resolve(result);
        } else {
						reactPromise.reject(Error("Unhandled error"));
				}
    }
}
