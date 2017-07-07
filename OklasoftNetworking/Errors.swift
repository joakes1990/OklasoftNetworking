//
//  Errors.swift
//  OklasoftNetworking
//
//  Created by Justin Oakes on 6/29/17.
//  Copyright © 2017 Oklasoft LLC. All rights reserved.
//

import Foundation
import OklasoftError

let retunedBadDataError: oklasoftError = oklasoftError(errorCode: 1005,
                                                       userInfo: nil,
                                                       localizedDescription: "Incomplete or corrupted data was returned from the server with out error.")
