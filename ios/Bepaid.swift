import begateway
import UIKit
import Foundation

@objc(BePaid)
class Bepaid: NSObject, RCTBridgeModule {
    var amount: Float = 0;
    var PUBLIC_STORE_KEY: String = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvextn45qf3NiNzqBYXMvcaSFlgoYE/LDuDDHtNNM4iWJP7BvjBkPcZu9zAfo5IiMxl660r+1E4PYWwr0iKSQ8+7C/WcSYwP8WlQVZH+2KtPmJgkPcBovz3/aZrQpj6krcKLklihg3Vs++TtXAbpCCbhIq0DJ3T+khttBqTGD+2x2vOC68xPgMwvnwQinfhaHEQNbtEcWWXPw9LYuOTuCwKlqijAEds4LgKSisubqrkRw/HbAKVfa659l5DJ8QuXctjp3Ic+7P2TC+d+rcfylxKw9c61ykHS1ggI/N+/KmEDVJv1wHvdy7dnT0D/PhArnCB37ZDAYErv/NMADz2/LuQIDAQAB";
    
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true;
    }
    
    @objc
    func constantsToExport() -> [AnyHashable : Any]! {
        return ["static": 0];
    }
    
    static func moduleName() -> String! {
        return "BePaid";
    }
    
    @objc(processPayment:withRejecter:)
    func processPayment(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        let paymentView = BepaidViewController();
        paymentView.paymentModule.settings.locale = "en";
        paymentView.modalPresentationStyle = .overFullScreen;
        paymentView.PUBLIC_STORE_KEY = self.PUBLIC_STORE_KEY;
        
        UIApplication.shared.keyWindow?.rootViewController?.present(paymentView, animated: true, completion: nil);
        paymentView.setPaymentView(amount: Int(amount), resolve: resolve, reject: reject);
    }
    
    @objc(setAmount:)
    func setAmount(amount: Float) -> Void {
        self.amount = amount;
    }
}
