//
//  UserDefaultsLightTests.swift
//  UserDefaultsLightTests
//
//  Created by Rezvantsev Viktor on 10.11.2020.
//

import XCTest
@testable import UserDefaultsLight

class UserDefaultsLightTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

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

class UserStorageTests: XCTestCase {
    
    // MARK: - Properties
    
    var user = UserMock(name: "Peter",
                         url: "www.taganrog.com",
                         age: 45,
                         pictureUrl: "myprofile/img45.jpg")
    let user2 = UserMock(name: "John",
                          url: "www.ru-ru",
                          age: 25,
                          pictureUrl: "myprofile/img01.jpg")
    let key = "InfiniteKey"
    
    // MARK: - Helpers
    
    func makeSUT() -> Storage {
        return Storage.shared
    }
    
    // MARK: - Test functions
    
    func testValidKey() {
        XCTAssertFalse(Storage.shared.isValueExists(forKey: "user"))
    }
    
    func testSetValue() {
        makeSUT().setValue(user, forKey: key)
        guard let object: UserMock = makeSUT().getValue(forKey: key) else {
            return
        }
        XCTAssertNotNil(object)
    }
    
    func testGetValue() {
        guard let object: UserMock = makeSUT().getValue(forKey: key) else {
            return
        }
        XCTAssertNil(object)
    }
    
    func testUpdateValue() {
        makeSUT().setValue(user, forKey: key)
        guard let object1: UserMock = makeSUT().getValue(forKey: key) else {
            return
        }
        makeSUT().updateValue(object: user2, forKey: key)
        guard let object2: UserMock = makeSUT().getValue(forKey: key) else {
            return
        }
        XCTAssertNotEqual(object1.name, object2.name)
    }
    
    func testDeleteObject() {
        makeSUT().setValue(user, forKey: key)
        makeSUT().removeValue(forKey: key)
        guard let object: UserMock = makeSUT().getValue(forKey: key) else {
            return
        }
        XCTAssertNil(object)
    }
    
    

}
