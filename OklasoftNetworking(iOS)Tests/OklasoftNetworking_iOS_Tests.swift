//
//  OklasoftNetworkingTests.swift
//  OklasoftNetworkingTests
//
//  Created by Justin Oakes on 6/29/17.
//  Copyright © 2017 Oklasoft LLC. All rights reserved.
//

import XCTest
@testable import OklasoftNetworking_iOS_
import OklasoftError_iOS_

class OklasoftNetworkingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let goodURL: URL = URL(string:"https://oklasoftware.com/")!
        let badURL: URL = URL(string:"https://kvnrkvnernvkernvk/thisurldoesnotexist")!
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(testGoodURL),
                                               name: .networkingSuccessNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(testBadURL),
                                               name: .networkingErrorNotification,
                                               object: nil)
        URLSession.shared.getReturnedDataFrom(url: goodURL, with: nil)
        URLSession.shared.getReturnedDataFrom(url: badURL, with: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGoodURL(aNotification: Notification) {
        guard let userInfo: [AnyHashable:Any] = aNotification.userInfo
            else {
                XCTFail()
                return
        }
        if let infoString:String = userInfo["key"] as? String {
            if infoString == userInfoKey {
                XCTAssert(true)
            }
        }
    }
    
    func testBadURL(aNotification: Notification) {
        guard let userInfo: [AnyHashable:Any] = aNotification.userInfo
            else {
                XCTFail()
                return
        }
        if let infoString:String = userInfo["key"] as? String {
            if infoString == errorInfoKey {
                XCTAssert(true)
            }
        }
    }
    
    func testErrorconversion() {
        let error: oklasoftError = oklasoftError(errorCode: 100,
                                                 userInfo: nil,
                                                 localizedDescription: "test error")
        let convertedError: Error = error.toError()
        XCTAssertNotNil(convertedError)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

