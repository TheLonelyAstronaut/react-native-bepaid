//
//  BepaidViewController.swift
//  Bepaid
//
//  Created by Vadzim Filipovich on 11/22/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit
import Foundation
import begateway

class BepaidViewController: UIViewController {
    var PUBLIC_STORE_KEY: String = "";
    let paymentModule = BGPaymentModule();
    var paymentCardView: BGCardView?;
    var promiseResolve: RCTPromiseResolveBlock!;
    var promiseReject: RCTPromiseRejectBlock!;
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    
    public func setPaymentView(amount: Int, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        promiseResolve = resolve;
        promiseReject = reject;
        
        let order = BGOrder(amount: amount, currency: "USD", description: "test", trackingId: "my_custom_variable");
        
        guard let paymentView = paymentModule.makePayment(publicKey: self.PUBLIC_STORE_KEY, transactionType: .payment, order: order)  else { return };
        paymentView.modalPresentationStyle = .fullScreen;
        paymentView.isModalInPopover = true;
        
        self.paymentCardView = paymentView;
        self.present(paymentView, animated: true, completion: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentModule.delegate = self;
        paymentModule.settings.endpoint = "https://checkout.bepaid.by/ctp/api";
        paymentModule.settings.returnURL = "https://testPayApp.com";
        paymentModule.settings.notificationURL = "https://testPayApp.com";
        paymentModule.settings.styleSettings.isSaveCardCheckBoxVisible = false;
        
        //NSLocalizedString not working in RN?
        paymentModule.settings.locale = "en";
    }
    
    required init?(coder: NSCoder) {
        fatalError("nope");
    }
}

extension BepaidViewController: BGPaymentModuleDelegate {
    func bgPaymentResult(status: BGPaymentModuleStatus){
        
        self.paymentCardView?.dismiss(animated: true, completion: nil);
        
        switch status {
        case .success:
            let dictionary: NSDictionary = [
                "token": "not implemented in iOS",
                "result": "SUCCESS",
                "error": "",
                "responseCode": 200
            ];
            self.promiseResolve(dictionary);
        case .canceled:
            let dictionary: NSDictionary = [
                "token": "not implemented in iOS",
                "result": "",
                "error": "CLOSED",
                "responseCode": 400
            ];
            self.promiseResolve(dictionary);
        case .error(let error):
            let dictionary: NSDictionary = [
                "token": "not implemented in iOS",
                "result": "",
                "error": error.localizedDescription,
                "responseCode": 401
            ];
            self.promiseResolve(dictionary);
        case .failure(let message):
            let dictionary: NSDictionary = [
                "token": "not implemented in iOS",
                "result": "",
                "error": message,
                "responseCode": 402
            ];
            self.promiseResolve(dictionary);
        }
        
        self.dismiss(animated: true, completion: nil);
    }
}
