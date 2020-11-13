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
        if isValid(fromKey: key.name) && isValueExists(forKey: key) {
            let data = try? PropertyListEncoder().encode(object)
            defaults.set(data, forKey: key.name)
        } else {
            print("Error, key is wrong or value exists")
        }
    }
    ///Issue an object by key and return the type T for further conversion to the desired type.
    public func getValue<T: Codable>(forKey key: UDLKey<T>) -> T? where T : Decodable {
        if let data = defaults.data(forKey: key.name) {
            let value = try? PropertyListDecoder().decode(key.type, from: data)
            return value
        } else {
            return nil
        }
    }
    
    ///If there is a value by key, it returns true
    public func isValueExists<T: Codable>(forKey key: UDLKey<T>) -> Bool {
        return defaults.object(forKey: key.name) != nil ? true : false
    }
    
    ///Remove the object by key.
    public func removeValue<T: Codable>(forKey key: UDLKey<T>) {
        defaults.removeObject(forKey: key.name)
    }
    
    ///Update a value for special key
    public func updateValue<T: Codable>(object: T, forKey key: UDLKey<T>) {
        guard let oldData = UserDefaults.standard.object(forKey: key.name) as? Data,
              let _ = try? PropertyListDecoder().decode(T.self, from: oldData) else {
            defaults.set(nil, forKey: key.name)
            return
        }
        defaults.set(object, forKey: key.name)
    }
    
    ///Check for the presence of the symbol, if key is valid return true
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
