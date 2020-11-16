//
//  UDManager.swift
//  StorageUDExamples
//
//  Created by Dmitry Sedov on 06.11.2020.
//

import Foundation


final public class UDLStorage {
    
    private let defaults = UserDefaults.standard
    
    public static let shared = UDLStorage()
    
    ///Save the object by key and validate it.
    public func setValue<T: Codable>(_ object: T, forKey key: UDLKey<T>) {
        let data = try? PropertyListEncoder().encode(object)
        defaults.set(data, forKey: key.name)
    }
    
    ///Issue an object by key and return the type T for further conversion to the desired type.
    public func getValue<T: Codable>(forKey key: UDLKey<T>) -> T? {
        if let data = defaults.data(forKey: key.name) {
            let value = try? PropertyListDecoder().decode(key.type, from: data)
            return value
        } else {
            return nil
        }
    }
    
    ///Remove the object by key.
    public func removeValue<T: Codable>(forKey key: UDLKey<T>) {
        defaults.removeObject(forKey: key.name)
    }
    
    /// If there is a value by key, it returns true
    public func isValueExists<T: Codable>(forKey key: UDLKey<T>) -> Bool {
        return defaults.object(forKey: key.name) != nil ? true : false
    }
    
    /// Remove all values for all keys
    public func removeAllValues() {
        guard let domain = Bundle.main.bundleIdentifier else {
            return
        }
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
}
