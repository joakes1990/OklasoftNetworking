//
//  Notifications.swift
//  OklasoftNetworking
//
//  Created by Justin Oakes on 6/29/17.
//  Copyright © 2017 Oklasoft LLC. All rights reserved.
//

import Foundation

public let userInfoKey: String = "returnedData"
public let errorInfoKey: String = "Error"

public struct errorInfo {
    let key: String
    let error: Error
    
    func toDict() -> [AnyHashable:Any]? {
        let dict: [AnyHashable:Any] = ["key" : key,
                                       "error" : error]
        return dict
    }
    
    
}

public struct HTTPInfo {
    let key : String
    let data: Data
    let metaData: URLResponse
    
    func toDict() -> [AnyHashable:Any]? {
        let dict: [AnyHashable:Any] = ["key" : key,
                                       "data" : data,
                                       "metaData" : metaData]
        return dict
    }
    
    
}

public extension Notification.Name {
    static let networkingErrorNotification = Notification.Name("URLSessionError")
    static let networkingSuccessNotification = Notification.Name("URLSessionSuccess")
}
