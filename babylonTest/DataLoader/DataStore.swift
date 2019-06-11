//
//  DataStore.swift
//  babylonTest
//
//  Created by Amish Patel on 11/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

protocol DataStoreable {
    var postsKeyString: String {get}
    var usersKeyString: String {get}
    var commentsKeyString: String {get}
    
    func saveObjects<T: Codable>(objects: [T], keyPath: String, completion: (() -> Void)?) throws
    func getObject<T: Codable>(forKeyPath keyPath: String) throws -> [T]
    
    func clearData(forKey key: String)
    
}

final class DataStore: DataStoreable {
    
    private let userDefaults = UserDefaults(suiteName: #file)!
    var postsKeyString = "com.amishpatel.babylonTest.posts"
    let usersKeyString = "com.amishpatel.babylonTest.users"
    let commentsKeyString = "com.amishpatel.babylonTest.comment"
    
    func saveObjects<T>(objects: [T], keyPath: String, completion: (() -> Void)?) throws where T : Decodable, T : Encodable {
        do {
            
            let data = try JSONEncoder().encode(objects)
            
            userDefaults.setValue(data, forKey: keyPath)
            userDefaults.synchronize()
            completion?()
            
        }
        catch let error {
            throw error
        }
    }
    
    func getObject<T>(forKeyPath keyPath: String) throws -> [T] where T : Decodable, T : Encodable {
        
        if let data = userDefaults.value(forKey: keyPath) as? Data {
            do {
                let objects = try JSONDecoder().decode([T].self, from: data)
                return objects
            } catch let error {
                throw error
            }
        }
        return [T]()
    }
    
    func clearData(forKey key: String) {
        userDefaults.setValue(nil, forKey: key)
    }
}
