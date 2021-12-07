//
//  AccountService.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 22.11.21.
//

import Foundation
import RealmSwift

class AccountService{
    
    class func addAccount(address: String,
                 number_of_transactions: Int,
                 final_balance: Double,
                 unconfirmed_balance: Double
    ){
        
        let account = initAccount(address: address, number_of_transactions: number_of_transactions, final_balance: final_balance, unconfirmed_balance: unconfirmed_balance)
        try? DataManager.realm.write{
            DataManager.realm.add(account)
        }
    }
    class func updateAccount(address: String,
                             number_of_transactions: Int,
                             final_balance: Double,
                             unconfirmed_balance: Double ){
        
        guard let account = getAccount(address: address).first
        else{
            return
        }
        try? DataManager.realm.write{
            account.number_of_transactions = number_of_transactions
            account.final_balance = final_balance
            account.unconfirmed_balance = unconfirmed_balance
        }
    }
    class func getAccount(address: String) -> Results<Account>{
        return DataManager.realm.objects(Account.self)
            .filter("address == %@", address)
    }
    class func doesAccountExist(address: String) -> Bool{
        return getAccount(address: address).first != nil
    }
    
    class func getAccounts() -> Results<Account>{
        return DataManager.realm.objects(Account.self)
        
    }
    class func initAccount(address: String,
                           number_of_transactions: Int,
                           final_balance: Double,
                           unconfirmed_balance: Double) -> Account{
        let account = Account()
        account.id = UUID().uuidString
        account.address = address
        account.number_of_transactions = number_of_transactions
        account.final_balance = final_balance
        account.unconfirmed_balance = unconfirmed_balance
        
        return account
    }
}
