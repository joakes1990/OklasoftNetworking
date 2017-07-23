//
//  Errors.swift
//  OklasoftNetworking
//
//  Created by Justin Oakes on 6/29/17.
//  Copyright © 2017 Oklasoft LLC. All rights reserved.
//

import Foundation
#if os(OSX)
import OklasoftError
#elseif os(iOS)
import OklasoftError_iOS_
#endif

let retunedBadDataError: oklasoftError = oklasoftError(errorCode: 1005,
                                                       userInfo: nil,
                                                       localizedDescription: "Incomplete or corrupted data was returned from the server with out error.")
