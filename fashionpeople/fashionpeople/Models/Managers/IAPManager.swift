//
//  IAPManager.swift
//  FashionPeople
//
//  Created by Andrey on 16.07.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit
import StoreKit

final class IAPManager: NSObject {
    
    //MARK: - Initialization
    
    static let shared = IAPManager()
    private override init() {}
    
    //MARK: - Property
    
    var products: [SKProduct] = []
    private var paymentQueue = SKPaymentQueue.default()
    
    //MARK: - Functions
    
    public func setupPurchase() {
        if SKPaymentQueue.canMakePayments() {
            paymentQueue.add(self)
            getProducts()
        }
    }
    
    public func purchase(_ productidentifier: String) {
       NotificationCenter.default.post(name: Notification.Name(productidentifier), object: nil)
        guard let product = products.filter ({$0.productIdentifier == productidentifier}).first
            else {return}
        paymentQueue.add(SKPayment(product: product))
    }
    
    private func getProducts() {
        let productRequest = SKProductsRequest(productIdentifiers: Set(IAP.IAPProducts.products))
        productRequest.delegate = self
        productRequest.start()
    }
    
}

//MARK: - ProductRequest

extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
        print(products.count)
    }
}

//MARK: - PaymnetTransactionObserver

extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .failed: failed($0)
            case .purchased: purchased($0)
            case .restored: restored($0)
            default: break }
        }
    }
    
    private func failed(_ transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError? {
            if transactionError.code != SKError.paymentInvalid.rawValue {
                print("Ошибка транзакции: \(String(describing: transactionError.localizedDescription))")
            }
        }
        paymentQueue.finishTransaction(transaction)
    }
    
    private func purchased(_ transaction: SKPaymentTransaction) {
        NotificationCenter.default.post(name: Notification.Name(transaction.payment.productIdentifier),
                                        object: nil)
        paymentQueue.finishTransaction(transaction)
    }
    
    private func restored(_ transaction: SKPaymentTransaction) {
         paymentQueue.finishTransaction(transaction)
    }
}
