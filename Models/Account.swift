//
//  Account.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 22.11.21.
//

import UIKit
import RealmSwift

class Account: Object {
    @Persisted var id: String = ""
    @Persisted var address: String = ""
    @Persisted var number_of_transactions: Int = 0;
    @Persisted var final_balance: Double = 0.0
    @Persisted var unconfirmed_balance: Double = 0.0
    
    static override func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(
        address: String,
        number_of_transactions: Int,
        final_balance: Double,
        unconfirmed_balance: Double
    ){
        self.init()
        self.address = address
        self.number_of_transactions = number_of_transactions
        self.final_balance = final_balance
        self.unconfirmed_balance = unconfirmed_balance

    }
}
