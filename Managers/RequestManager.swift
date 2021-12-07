//
//  RequestManager.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 22.11.21.
//

import Foundation
import Alamofire

enum NetworkErrors: Error{
    case cannotParseData
}

class RequestManager{
    static var url: String = "https://eth1.trezor.io/api/v2/"
    
    class func fetchAccount(address: String, completion: @escaping((_ error: Error?, _ account: Account?) ->Void)){
        AF.request(
            url + "address/" + address,
            method: .get
        )
            .responseJSON { result in
                if result.error != nil {
                    completion(result.error, nil)
                    return
                }
                guard let resultValue = result.value as? [String: Any],
                      let address = resultValue["address"] as? String,
                      let numberOfTransactions = resultValue["txs"] as? Int,
                      let finalBalnce = resultValue["balance"]  as? String,
                      let unconfirmedBalance = resultValue["unconfirmedBalance"] as? String,
                      var finalBalanceDouble = Double(finalBalnce),
                      var unconfirmedBalanceDouble = Double(unconfirmedBalance)
                else{
                    completion(NetworkErrors.cannotParseData, nil)
                    return
                }
                finalBalanceDouble /= pow(10, 18)
                unconfirmedBalanceDouble /= pow(10, 18)
               let account = Account(address: address,
                                           number_of_transactions: numberOfTransactions,
                                           final_balance: finalBalanceDouble,
                                    unconfirmed_balance: unconfirmedBalanceDouble )

                if(AccountService.doesAccountExist(address: address)){
                    AccountService.updateAccount(address: address, number_of_transactions: numberOfTransactions, final_balance: finalBalanceDouble, unconfirmed_balance: unconfirmedBalanceDouble)
                }else{
                    AccountService.addAccount(address: address, number_of_transactions: numberOfTransactions, final_balance: finalBalanceDouble, unconfirmed_balance: unconfirmedBalanceDouble
                    )
                }
                
                completion(nil, account)
            }
    }
    
    class func fetchBlockchainStatus(completion: @escaping((_ error: Error?, _ status: BlockchainStatus?) -> Void)) -> Void{
        AF.request(self.url,
                   method: .get)
            .responseJSON{ result in
                if result.error != nil{
                    completion(result.error, nil)
                    return
                }
                
                guard let resultValue = result.value as? [String: Any],
                      let blockbook = resultValue["blockbook"] as? [String: Any],
                      let backend = resultValue["backend"] as? [String: Any],
                      let coin = blockbook["coin"] as? String,
                      let chain = backend["chain"] as? String,
                      let blocks = backend["blocks"] as? Int,
                      let blockHash = backend["bestBlockHash"] as? String,
                      let difficulty = backend["difficulty"] as? String,
                      let lastBlockTime = blockbook["lastBlockTime"] as? String
                else{
                    completion(NetworkErrors.cannotParseData, nil)
                    return
                }
                let dateString = formatDate(strDate: lastBlockTime)
                
                let status = BlockchainStatus(
                                    name: coin,
                                    chain: chain,
                                    lastBlock: blocks,
                                    lastBlockHash: blockHash,
                                    lastBlockTime: dateString,
                                    difficulty: Int(difficulty) ?? 0
                            )
                
                // Add the new status to the local database
                if BlockchainStatusService.doesBlockchainStatusExists(blockchainName: status.name){
                    BlockchainStatusService.updateBlockchainStatus(status: status)
                }else{
                    BlockchainStatusService.addBlockchainStatus(status: status)
                }
                
                completion(nil, status)
            }
        
    }
    class func fetchLastBlock(height: Int,completion: @escaping(_ error: Error?,_ block: Block?) -> Void){

        AF.request(
            url + "block/\(height)",
                   method: .get)
            .responseJSON { result in
                if result.error != nil{
                    completion(result.error, nil)
                    return
                }
                
                guard let resultValue = result.value as? [String: Any],
                      let hash = resultValue["hash"] as? String,
                      let confirmations = resultValue["confirmations"] as? Int,
                      let time = resultValue["time"] as? Double,
                      let numberOfTxs = resultValue["txCount"] as? Int,
                      let nonce = resultValue["nonce"] as? String
                else{
                    completion(NetworkErrors.cannotParseData, nil)
                    return
                }
                
                let block = Block(
                    hash:hash,
                    height: height,
                    time: convertTimestapmToDateString(timestamp: time),
                    confirmations: confirmations,
                    numberOfTxs: numberOfTxs,
                    nonce: nonce
                )
                
                completion(nil, block)
                
            }
        
    }
    static func formatDate(strDate: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSSZ"
        if let date = dateFormatter.date(from: strDate){
            dateFormatter.dateFormat = "yyyy-mm-dd HH:mm"
            return dateFormatter.string(from: date)
        }else{
            return "No date"
        }
        
    }
    static func convertTimestapmToDateString(timestamp: Double) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
        }
    
}
