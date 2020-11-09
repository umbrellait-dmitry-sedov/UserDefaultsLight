//
//  UDManager.swift
//  StorageUDExamples
//
//  Created by Dmitry Sedov on 06.11.2020.
//

import Foundation

public class Storage {
    
    // commit 
    private let defaults = UserDefaults.standard
    
    static let shared = Storage()
    
    public func setValue<T>(object: T, key: String) { // hide impementtion archiving
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false) {
            print("value was added to key")
            defaults.set(savedData, forKey: key)
        } else {
            defaults.removeObject(forKey: key)
        }
    }
    
    public func getValue<T>(model: T, key: String) -> T? { // hide impementtion archiving
        guard let savedData = UserDefaults.standard.object(forKey: key) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? T else { return nil }
        return decodedModel
    }
    
    public func objectIsExist(forKey key: String) -> Bool {
        let flag = defaults.object(forKey: key) != nil ? true : false // Chech the value for nil
        return flag
      }
}
