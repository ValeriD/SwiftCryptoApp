//
//  BlockService.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 3.12.21.
//

import Foundation
class BlockService{
    
    class func addBlock(block: Block){
        try? DataManager.realm.write{
            DataManager.realm.add(block)
        }
    }
    
    class func updateBlock(block:Block){
        guard let oldBlock = getLatestBlock()
        else{
            return
        }
        try? DataManager.realm.write{
            oldBlock.blockHash = block.blockHash
            oldBlock.blockHeight = block.blockHeight
            oldBlock.blockTime = block.blockTime
            oldBlock.blockConfirmations = block.blockConfirmations
            oldBlock.blockNumberTxs = block.blockNumberTxs
            oldBlock.blockNonce = block.blockNonce
        }
    }
    
    class func getLatestBlock() -> Block?{
        return DataManager.realm.objects(Block.self).first
    }
    
    
}
