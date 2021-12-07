//
//  BlockhainStatusService.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 3.12.21.
//

import Foundation
import RealmSwift


class BlockchainStatusService{
    
    class func addBlockchainStatus(status: BlockchainStatus){
        
        try? DataManager.realm.write{
            DataManager.realm.add(status)
        }
    }
    
    class func updateBlockchainStatus(status: BlockchainStatus){
        guard let blockchainStatus = getBlockchainStatus(blockchainName:  status.name).first
        else{
            return
        }
        
        
        
        try? DataManager.realm.write{
            blockchainStatus.chain = status.chain
            blockchainStatus.lastBlock = status.lastBlock
            blockchainStatus.lastBlockHash = status.lastBlockHash
            blockchainStatus.lastBlockTime = status.lastBlockTime
            blockchainStatus.difficulty = status.difficulty
        }
    }
    
    class func getBlockchainStatus(blockchainName: String) -> Results<BlockchainStatus>{
        return DataManager.realm.objects(BlockchainStatus.self).filter("name == %@", blockchainName)
    }
    
    class func doesBlockchainStatusExists(blockchainName: String) -> Bool{
        
        return getBlockchainStatus(blockchainName: blockchainName).first != nil
    }
}
