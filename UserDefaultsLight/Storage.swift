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
    
    ///Save object from key and check key.
    public func setValue<T: Codable>(_ object: T, forKey key: String) {
        if isValid(fromKey: key) && isValueExists(forKey: key) {
            let data = try? PropertyListEncoder().encode(object)
            defaults.set(data, forKey: key)
        } else {
            print("Error, key is wrong or value exists")
        }
    }
    ///Get object from key.
    public func getValue<T: Codable>(forKey key: String) -> T? {
        if let data = defaults.value(forKey: key) as? Data {
            return data as? T
        } else {
            return nil
        }
    }
    
    ///Check a value in the store.
    public func isValueExists(forKey key: String) -> Bool {
            return defaults.object(forKey: key) != nil ? true : false
    }
    
    ///Delete object without instantiating user defaults.
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
    
    ///Check for the presence of the symbol
    private func isValid(fromKey key: String) -> Bool {
        let wrongSymbols = [" ", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", ":", ";"]
            for value in wrongSymbols {
                if key.contains(value) {
                    return false
                }
            }
        return true
    }
 
}
