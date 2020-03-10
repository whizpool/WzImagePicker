//
//  WZImagePickerSDKTests.swift
//  WZImagePickerSDKTests
//
//  Created by Adeel on 18/02/2020.
//  Copyright © 2020 Adeel. All rights reserved.
//

import XCTest
@testable import WZImagePickerSDK

class WZImagePickerSDKTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHelloWorld() {
        let hw = HelloWorld()

        // test public method
        XCTAssertEqual(hw.hello(to: "World"), "Hello World")

        // test internal property
        XCTAssertEqual(hw.greet, "Hello")
    }
    

}
