//
//  UDKey.swift
//  UserDefaultsLight
//
//  Created by Rezvantsev Viktor on 13.11.2020.
//


public struct UDLKey<T> {
    let name: String
    let type: T.Type
    
    init(name: String, type: T.Type) {
        self.name = name
        self.type = type
    }
}
