//
//  UserDefaultsLightTests.swift
//  UserDefaultsLightTests
//
//  Created by Rezvantsev Viktor on 10.11.2020.
//

import XCTest
@testable import UserDefaultsLight

struct UserMock: Codable {
    let name: String?
    let url: String?
    let age: Int?
    let pictureUrl: String?
    
    init(name: String?, url: String?, age: Int?, pictureUrl: String?) {
        self.name = name
        self.url = url
        self.age = age
        self.pictureUrl = pictureUrl
    }
}

class UserDefaultsLightTests: XCTestCase {

    // MARK: - Properties
    
    var user = UserMock(name: "Peter",
                         url: "www.taganrog.com",
                         age: 45,
                         pictureUrl: "myprofile/img45.jpg")
    let user2 = UserMock(name: "John",
                          url: "www.ru-ru",
                          age: 25,
                          pictureUrl: "myprofile/img01.jpg")
    let key = UDLKey(name: "InfiniteKey", type: UserMock.self)
    
    
    // MARK: - Test functions
    
    func testValidKey() {
        XCTAssertFalse(UDLStorage.shared.isValueExists(forKey: key))
    }
    
    func testSetValue() {
        UDLStorage.shared.setValue(user, forKey: key)
        guard let object: UserMock = UDLStorage.shared.getValue(forKey: key) else {
            return
        }
        XCTAssertNotNil(object)
    }
    
    func testGetValue() {
        guard let object: UserMock = UDLStorage.shared.getValue(forKey: key) else {
            return
        }
        XCTAssertNil(object)
    }
    
    func testUpdateValue() {
        UDLStorage.shared.setValue(user, forKey: key)
        guard let object1: UserMock = UDLStorage.shared.getValue(forKey: key) else {
            return
        }
        UDLStorage.shared.updateValue(object: user2, forKey: key)
        guard let object2: UserMock = UDLStorage.shared.getValue(forKey: key) else {
            return
        }
        XCTAssertNotEqual(object1.name, object2.name)
    }
    
    func testDeleteObject() {
        UDLStorage.shared.setValue(user, forKey: key)
        UDLStorage.shared.removeValue(forKey: key)
        guard let object: UserMock = UDLStorage.shared.getValue(forKey: key) else {
            return
        }
        XCTAssertNil(object)
    }

}
