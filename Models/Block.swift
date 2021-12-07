//
//  Block.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 3.12.21.
//

import UIKit
import RealmSwift

class Block: Object {
    @Persisted var id: String
    @Persisted var blockHash: String
    @Persisted var blockHeight: Int
    @Persisted var blockTime: String
    @Persisted var blockConfirmations: Int
    @Persisted var blockNumberTxs: Int
    @Persisted var blockNonce: String
    
    static override func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(
        hash: String,
        height: Int,
        time: String,
        confirmations: Int,
        numberOfTxs: Int,
        nonce: String
    ){
        self.init()
        self.blockHash = hash
        self.blockHeight = height
        self.blockTime = time
        self.blockConfirmations = confirmations
        self.blockNumberTxs = numberOfTxs
        self.blockNonce = nonce
    }
    
}
