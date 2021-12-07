//
//  DBManager.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 22.11.21.
//

import Foundation
import RealmSwift

enum LocalDataManager: Error{
    case wrongQueue
}


class DataManager{
    static let realm: Realm = {
        return try! initializeRealm(checkForMainThread: true)
    }()
    static func getInsance() -> Realm{
        return realm
    }
    
    class func initializeRealm(checkForMainThread: Bool = false, queue: DispatchQueue = DispatchQueue.main) throws -> Realm{
        if checkForMainThread{
            guard OperationQueue.current?.underlyingQueue == DispatchQueue.main
            else{
                throw LocalDataManager.wrongQueue
            }
        }
        do{
            return try Realm(configuration: realmConfiguration, queue: queue)
            
        }catch{
            throw error
        }
    }
    
    static let realmConfiguration: Realm.Configuration = {
        	
        var configuration = Realm.Configuration.defaultConfiguration
        
        configuration.schemaVersion = 2
        configuration.migrationBlock = { ( migration, version ) in}
    
        return configuration
    }()
    
    
}
