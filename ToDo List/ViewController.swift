//
//  ViewController.swift
//  ToDo List
//
//  Created by prashanth on 11/6/14.
//  Copyright (c) 2014 prashanth. All rights reserved.
//

import UIKit
import PassKit
import WebKit


class ViewController: UIViewController,WKScriptMessageHandler {
    
    var selectedPhone:String?
    var webView: WKWebView?
    
    @IBOutlet weak var containerView: UIView! = nil
    

    /*
       Setting up webview and adding controls to transfer data to/from webview
    */
    override func loadView() {
        super.loadView()
        var isPaymentEligible = PKPaymentAuthorizationViewController.canMakePayments()
        
        var contentController = WKUserContentController();
        
        if(!isPaymentEligible){
            var userScript = WKUserScript(
                source: "displayApplePayment()",
                injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
                forMainFrameOnly: true
            )
            contentController.addUserScript(userScript)
            
            contentController.addScriptMessageHandler(
                self,
                name: "callbackHandler"
            )
        }
        
        var config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(
            frame: self.view.frame,
            configuration: config
        )
        self.view = self.webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(selectedPhone)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /*
       Loading webpage in webview
    */
    override func viewDidAppear(animated: Bool) {
        var urlPath = NSBundle.mainBundle().pathForResource("sample", ofType:"html")
        var url = NSURL(fileURLWithPath: urlPath!)
        var request = NSURLRequest(URL: url!)
        self.webView!.loadRequest(request)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     Used for interaction with webview.
    */
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
            println(" \(message.body)")
            self.applePaymentProcess()
        }
    }
    
    /*
        Method to make apple pay
    */
    func applePaymentProcess(){
        
        println("Hello payment World before check ")
        
        if(PKPaymentAuthorizationViewController.canMakePayments()){
            
            println("Hello payment World ")
            
            let pkRequest = PKPaymentRequest();
            pkRequest.countryCode = "US"
            pkRequest.currencyCode = "USD"
            pkRequest.supportedNetworks = [PKPaymentNetworkAmex,PKPaymentNetworkMasterCard,PKPaymentNetworkVisa]
            pkRequest.merchantCapabilities = PKMerchantCapability.CapabilityEMV
            
//            pkRequest.merchantIdentifier =
            
            let item1 = PKPaymentSummaryItem.init(label:"motoX", amount:34.5)
            let item2 = PKPaymentSummaryItem.init(label:"motoG", amount:30.5)
            
            pkRequest.paymentSummaryItems = [item1,item2]
            
            var paymentPane = PKPaymentAuthorizationViewController.init(paymentRequest:pkRequest)
            
        }
        
    }
    

    

    
    
}

