//
//  UDManager.swift
//  StorageUDExamples
//
//  Created by Dmitry Sedov on 06.11.2020.
//

import Foundation


public class Storage {
    
    private let defaults = UserDefaults.standard
    
    public static let shared = Storage()
    
    ///Hide archiving implementation and check key.
    public func setValue<T: Codable>(_ object: T, forKey key: String) {
        if key != "" {
            let data = try? PropertyListEncoder().encode(object)
            defaults.set(data, forKey: key)
        }
    }
    ///Hide implementation unarchiving.
    public func getValue<T: Codable>(_ object: T, forKey key: String) -> T? {
        if let data = defaults.value(forKey: key) as? Data {
            return try? PropertyListDecoder().decode(T.self, from: data)
        } else {
            return object
        }
    }
    
    ///Check a value in the store.
    public func objectIsExist(forKey key: String) -> Bool {
            let flag = defaults.object(forKey: key) != nil ? true : false
            return flag
    }
    
    ///Delete without instantiating user defaults.
    public func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
    /// Update a value for special key
    ///

    /// Parameter value: new value set instead old value for key.
    public func updateValue<T: Codable>(object: T, forKey key: String) {
        guard let oldData = UserDefaults.standard.object(forKey: key) as? Data,
              let decodedModel = try? PropertyListDecoder().decode(T.self, from: oldData) as? T else {
            defaults.set(nil, forKey: key)
            return
        }
        defaults.set(object, forKey: key)
    }
}
