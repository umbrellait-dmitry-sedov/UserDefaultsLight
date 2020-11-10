//
//  UDManager.swift
//  StorageUDExamples
//
//  Created by Dmitry Sedov on 06.11.2020.
//

import Foundation

public class Storage {
    
    // Не совсем понятно, что значит коммит
    // commit 
    private let defaults = UserDefaults.standard
    
    static let shared = Storage()
    
    // Почему в методе Set используется название для объекта Object, а для метода Get - model?
    // Почему справа от открывающей скобки идёт комментарий? Как по
    // мне лучше писать так:
    // hide impementtion archiving
    
    public func setValue<T>(object: T, key: String) { // hide impementtion archiving
        
        // Не совсем понятно нейминг переменной savedData, логичнее использовать archivedData
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false) {
            print("value was added to key")
            defaults.set(savedData, forKey: key)
        } else {
            defaults.removeObject(forKey: key)
        }
    }
    
    public func getValue<T>(model: T, key: String) -> T? { // hide impementtion archiving
        // Когда идёт конструкция guard лучше всё таки писать вот так:
//        guard let savedData = UserDefaults.standard.object(forKey: key) as? Data,
//              let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? T else {
//            return nil
//        }
        guard let savedData = UserDefaults.standard.object(forKey: key) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? T else { return nil }
        return decodedModel
    }
    
    /// Update a value for special key
    ///
    /// Parameter value: set new value instead of old value for key
    public func updateValue<T>(_ value: T, forKey key: String) {
        guard let oldData = UserDefaults.standard.object(forKey: key) as? Data,
              let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(oldData) as? T else {
            defaults.set(nil, forKey: key)
            return
        }
        defaults.set(value, forKey: key)
    }
    
    public func objectIsExist(forKey key: String) -> Bool {
        let flag = defaults.object(forKey: key) != nil ? true : false // Chech the value for nil
        return flag
      }
}
