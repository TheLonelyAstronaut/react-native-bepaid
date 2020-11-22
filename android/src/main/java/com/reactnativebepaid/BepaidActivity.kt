package com.reactnativebepaid

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.begateway.mobilepayments.OnPaymentResultListener
import com.begateway.mobilepayments.PaymentBuilder
import com.begateway.mobilepayments.StyleSettings
import com.begateway.mobilepayments.TransactionType
import com.begateway.mobilepayments.model.PaymentResultResponse
import com.facebook.react.bridge.Promise
import org.json.JSONObject

class BepaidActivity : AppCompatActivity(), OnPaymentResultListener {
  private val PUBLIC_STORE_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArO7bNKtnJgCn0PJVn2X7QmhjGQ2GNNw412D+NMP4y3Qs69y6i5T/zJBQAHwGKLwAxyGmQ2mMpPZCk4pT9HSIHwHiUVtvdZ/78CX1IQJON/Xf22kMULhquwDZcy3Cp8P4PBBaQZVvm7v1FwaxswyLD6WTWjksRgSH/cAhQzgq6WC4jvfWuFtn9AchPf872zqRHjYfjgageX3uwo9vBRQyXaEZr9dFR+18rUDeeEzOEmEP+kp6/Pvt3ZlhPyYm/wt4/fkk9Miokg/yUPnk3MDU81oSuxAw8EHYjLfF59SWQpQObxMaJR68vVKH32Ombct2ZGyzM7L5Tz3+rkk7C4z9oQIDAQAB";

  private val YOUR_RETURN_URL = "https://YOUR_RETURN_URL.com"
  private val YOUR_CHECKOUT_ENDPOINT = "https://checkout.begateway.com/ctp/api/"
  private val YOUR_NOTIFICATION_URL = "https://webhook.site/6a7aeafe-fccb-4b2f-ae48-070cf187d49b"

  override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState);
      setContentView(R.layout.activity_bepaid);

      val paymentModule = PaymentBuilder()
        	.setTestMode(true)
        	.setEndpoint(YOUR_CHECKOUT_ENDPOINT)
        	.setReturnUrl(YOUR_RETURN_URL)
        	.setNotificationUrl(YOUR_NOTIFICATION_URL)
        	.setTransactionType(TransactionType.PAYMENT)
        	.setDebugMode(true)
        	.setPaymentResultListener(this)
        	.setStyleSettings(StyleSettings().setSaveCardCheckBoxVisible(false))
        	.build(applicationContext, this)

			var amout = intent.getDoubleExtra("amount", 0.0).toInt();

      var ORDER_JSON = JSONObject("{\n" +
        	"   \"amount\": \"${amout.toString()}\",\n" +
        	"   \"currency\": \"USD\",\n" +
        	"   \"description\": \"Payment description\", \n" +
        	"   \"tracking_id\" : \"merchant_id\", \n" +
        	"   \"additional_data\": {\n" +
        	"      \"contract\": [ \"recurring\", \"card_on_file\" ] \n" +
        	"   }\n" +
        	"}");

			paymentModule.payWithPublicKey(PUBLIC_STORE_KEY, ORDER_JSON);
  }

  override fun onPaymentResult(paymentResult: PaymentResultResponse?) {
    	intent = Intent();
    	intent.putExtra("result", paymentResult?.status.toString());
    	intent.putExtra("error", paymentResult?.error.toString());
    	intent.putExtra("token", paymentResult?.token);
			intent.putExtra("responseCode", paymentResult?.responseCode);

    	setResult(100, intent);
    	finish();
  }
}
