//
//  BlockchainStatus.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 30.11.21.
//

import UIKit
import RealmSwift

class BlockchainStatus: Object {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var chain: String
    @Persisted var lastBlock: Int
    @Persisted var lastBlockHash: String
    @Persisted var lastBlockTime: String
    @Persisted var difficulty: Int
    
    static override func primaryKey() -> String? {
        return "id"
    }
   
    convenience init(name: String,
         chain:String,
         lastBlock: Int,
         lastBlockHash: String,
         lastBlockTime: String,
         difficulty: Int){
        self.init()
        self.name = name
        self.chain = chain
        self.lastBlock = lastBlock
        self.lastBlockHash = lastBlockHash
        self.lastBlockTime = lastBlockTime
        self.difficulty = difficulty
    }
}
