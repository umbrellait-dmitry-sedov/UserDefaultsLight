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
        if name.isValid() {
            self.name = name
        } else {
            fatalError("This name is not valid")
        }
        self.type = type
    }
}

extension String {
    ///Check for the presence of the symbol, if key is valid return true
    func isValid() -> Bool {
        let wrongSymbols = [" ", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", ":", ";"]
            for value in wrongSymbols {
                if self.contains(value) {
                    return false
                }
            }
        return true
    }
}
