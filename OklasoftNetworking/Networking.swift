//
//  Networking.swift
//  OklasoftNetworking
//
//  Created by Justin Oakes on 6/29/17.
//  Copyright © 2017 Oklasoft LLC. All rights reserved.
//

import Foundation

public extension URLSession  {
    //MARK: Networking data types and structures
    public typealias networkCompletion = (Data?, URLResponse?, Error?) -> Void
    
    public func getReturnedDataFrom(url: URL, with completion: networkCompletion?) {
        let session: URLSession = .shared
        let task: URLSessionDataTask = session.dataTask(with: url,
                                                        completionHandler: completion ?? URLSession.standardCompletion)
        task.resume()
    }
    
    static let standardCompletion: networkCompletion = {(data, responce, error) in
        if let foundError:Error = error {
            NotificationCenter.default.post(name: .networkingErrorNotification,
                                            object: nil,
                                            userInfo:errorInfo(key: errorInfoKey, error: foundError).toDict())
            return
        }
        guard let foundData: Data = data,
            let metaData: URLResponse = responce else {
                let incompleteData: Error = oklasoftError(errorCode: 1005,
                                                          userInfo: nil,
                                                          localizedDescription: NSLocalizedString("error1005", comment: "Incomplete or corrupted data was returned from the server with out error."))
                NotificationCenter.default.post(name: .networkingErrorNotification,
                                                object: nil,
                                                userInfo:errorInfo(key: errorInfoKey, error: incompleteData).toDict())
                return
        }
        let httpInfo: HTTPInfo = HTTPInfo(key: userInfoKey,
                                          data: foundData,
                                          metaData: metaData)
        NotificationCenter.default.post(name: .networkingSuccessNotification,
                                        object: nil,
                                        userInfo: httpInfo.toDict())
    }
}
