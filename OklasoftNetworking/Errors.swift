//
//  Errors.swift
//  OklasoftNetworking
//
//  Created by Justin Oakes on 6/29/17.
//  Copyright © 2017 Oklasoft LLC. All rights reserved.
//

import Foundation

struct oklasoftError: Error {
    let domain: String = "com.oklasoft"
    var errorCode: Int
    var userInfo: [AnyHashable : Any]?
    var localizedDescription: String
    
    func toError() -> Error {
        let newError: NSError = NSError(domain: domain,
                                        code: errorCode,
                                        userInfo: userInfo)
        return newError as Error
    }
    
}
