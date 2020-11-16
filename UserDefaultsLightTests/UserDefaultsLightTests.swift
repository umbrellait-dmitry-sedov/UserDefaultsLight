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
    let key = UDLKey(name: "infiniteKey", type: UserMock.self)
    let keyForUser2 = UDLKey(name: "User2Key", type: UserMock.self)
    
    
    // MARK: - Test functions
    
    func testValidKey() {
        XCTAssertFalse(UDLStorage.shared.isValueExists(forKey: keyForUser2))
        XCTAssertFalse(UDLStorage.shared.isValueExists(forKey: key))
    }
    
    func testSetValue() {
        UDLStorage.shared.setValue(user, forKey: key)
        let object: UserMock? = UDLStorage.shared.getValue(forKey: key)
        XCTAssertNotNil(object)
    }
    
    func testGetValue() {
        let object: UserMock? = UDLStorage.shared.getValue(forKey: key)
        XCTAssertNil(object)
    }
        
    func testDeleteObject() {
        UDLStorage.shared.setValue(user, forKey: key)
        UDLStorage.shared.removeValue(forKey: key)
        let object: UserMock? = UDLStorage.shared.getValue(forKey: key)
        XCTAssertNil(object)
    }
    
    func testRemoveAllObjects() {
        UDLStorage.shared.setValue(user, forKey: key)
        UDLStorage.shared.setValue(user2, forKey: keyForUser2)
        UDLStorage.shared.removeAllValues()
        let user: UserMock? = UDLStorage.shared.getValue(forKey: key)
        let user2: UserMock? = UDLStorage.shared.getValue(forKey: keyForUser2)
        XCTAssertNil(user)
        XCTAssertNil(user2)
    }
    
    override func setUp() {
        UDLStorage.shared.removeValue(forKey: key)
        UDLStorage.shared.removeValue(forKey: keyForUser2)
    }

}
