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
    
    /// If there is a value by key, it's replaces the new value
    /// or add value to new key
    public func isValueExists<T: Codable>(object: T, forKey key: UDLKey<T>) {
        guard let oldData = defaults.object(forKey: key.name) as? Data,
              let _ = try? PropertyListDecoder().decode(T.self, from: oldData) else {
            return
        }
        let data = try? PropertyListEncoder().encode(object)
        defaults.set(data, forKey: key.name)
    }
    
    /// Remove all values for all keys
    public func removeAllValues() {
        guard let domain = Bundle.main.bundleIdentifier else {
            return
        }
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
    /// Version 2
//    public func removeAllValues() {
//        let dictionary = defaults.dictionaryRepresentation()
//        dictionary.keys.forEach { key in
//            defaults.removeObject(forKey: key)
//        }
//    }
}
