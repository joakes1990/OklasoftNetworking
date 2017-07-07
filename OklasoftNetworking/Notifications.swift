//
//  Notifications.swift
//  OklasoftNetworking
//
//  Created by Justin Oakes on 6/29/17.
//  Copyright © 2017 Oklasoft LLC. All rights reserved.
//

import Foundation

//MARK: User info dictionary keys

/* These are a hand full of predefined strings to be reused in notifications
 * across libraries and applications so data collections can be as similar
 * and spend as little time weakly typed as possible
*/
public let userInfoKey: String = "returnedData"
public let errorInfoKey: String = "Error"


//MARK: User info data structures

/* These are some basic structs that can export to a AnyHashable:Any dict for
 * use in the user info property in a notification.
 * you can add additional structs to your framework or app
*/

public struct errorInfo: UserInformer {
    let key: String = errorInfoKey
    let error: Error
    
    public init(error: Error) {
        self.error = error
    }
    
    public func toDict() -> [AnyHashable:Any]? {
        let dict: [AnyHashable:Any] = ["key" : key,
                                       "error" : error]
        return dict
    }
}

public struct HTTPInfo: UserInformer {
    let key : String
    let data: Data
    let metaData: URLResponse
    
    public func toDict() -> [AnyHashable:Any]? {
        let dict: [AnyHashable:Any] = ["key" : key,
                                       "data" : data,
                                       "metaData" : metaData]
        return dict
    }
}

protocol UserInformer {
    var key: String { get }
    // This should return optionals when extended in the future becasue you have no idea
    // how this will be extended and by who in the future.
    func toDict() -> [AnyHashable:Any]?
}

public extension Notification.Name {
    static let networkingErrorNotification = Notification.Name("URLSessionError")
    static let networkingSuccessNotification = Notification.Name("URLSessionSuccess")
}
