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
    
    /// Метод для установки значений codable. object принимает и возвращает. опсать параметры
    public func setValue<T: Codable>(_ object: T, forKey: String) { // hide impementtion archiving
        if let data = try? PropertyListEncoder().encode(object) {
            defaults.set(data, forKey: forKey)
        }
    }
    
    public func getValue<T: Codable>(_ object: T, forKey: String) -> T? { // hide implementation archiving
        if let data = defaults.value(forKey: forKey) as? Data {
            return try? PropertyListDecoder().decode(T.self, from: data)
        } else {
            return object
        }
    }
    
    public func objectIsExist(forKey key: String) -> Bool {
        let flag = defaults.object(forKey: key) != nil ? true : false // Chech the value for nil

        return flag
      }
    
    ///delete without instantiating user defaults
    public func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
    /// Update a value for special key
    ///
    /// Parameter value: new value set instead old value for key
    public func updateValue<T>(newValue: T, forKey key: String) {
        guard let oldData = UserDefaults.standard.object(forKey: key) as? Data,
              let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(oldData) as? T else {
            defaults.set(nil, forKey: key)
            return
        }
        defaults.set(newValue, forKey: key)
    }
}
