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
    let keyForUser2 = UDLKey(name: "User2Key", type: UserMock.self)
    
    
    // MARK: - Test functions
    
    func testValidKey() {
        XCTAssertNotNil(UDLStorage.shared.isValueExists(object: user, forKey: key))
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
        
    func testDeleteObject() {
        UDLStorage.shared.setValue(user, forKey: key)
        UDLStorage.shared.removeValue(forKey: key)
        guard let object: UserMock = UDLStorage.shared.getValue(forKey: key) else {
            return
        }
        XCTAssertNil(object)
    }
    
    func testRemoveAllObjects() {
        UDLStorage.shared.setValue(user, forKey: key)
        UDLStorage.shared.setValue(user, forKey: key)
        UDLStorage.shared.removeAllValues()
        guard let user: UserMock = UDLStorage.shared.getValue(forKey: key),
              let user2: UserMock = UDLStorage.shared.getValue(forKey: keyForUser2)else {
            return
        }
        XCTAssertNil(user)
        XCTAssertNil(user2)
    }

}
