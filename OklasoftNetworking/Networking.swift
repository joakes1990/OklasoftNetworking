//
//  Networking.swift
//  OklasoftNetworking
//
//  Created by Justin Oakes on 6/29/17.
//  Copyright © 2017 Oklasoft LLC. All rights reserved.
//

import Foundation
//MARK: Networking data types and structures
public typealias networkCompletion = (Data?, URLResponse?, Error?) -> Void

public extension URLSession  {
        
    public func getReturnedDataFrom(url: URL, with completion: networkCompletion?) {
        let task: URLSessionDataTask = self.dataTask(with: url,
                                                        completionHandler: completion ?? URLSession.standardCompletion)
        task.resume()
    }
    
    public func getReturnedDataFrom(url: URL, returning notification: Notification.Name) {
        let task: URLSessionDataTask = self.dataTask(with: url) { (data, responce, error) in
            if let foundError:Error = error {
                NotificationCenter.default.post(name: .networkingErrorNotification,
                                                object: nil,
                                                userInfo:errorInfo(error: foundError).toDict())
                return
            }
            guard let foundData: Data = data,
                let metaData: URLResponse = responce else {
                    NotificationCenter.default.post(name: .networkingErrorNotification,
                                                    object: nil,
                                                    userInfo:errorInfo(error: retunedBadDataError).toDict())
                    return
            }
            let httpInfo: HTTPInfo = HTTPInfo(key: userInfoKey,
                                              data: foundData,
                                              metaData: metaData)
            NotificationCenter.default.post(name: notification,
                                            object: nil,
                                            userInfo: httpInfo.toDict())
        }
        task.resume()
    }
    
    static let standardCompletion: networkCompletion = {(data, responce, error) in
        if let foundError:Error = error {
            NotificationCenter.default.post(name: .networkingErrorNotification,
                                            object: nil,
                                            userInfo:errorInfo(error: foundError).toDict())
            return
        }
        guard let foundData: Data = data,
            let metaData: URLResponse = responce else {
                NotificationCenter.default.post(name: .networkingErrorNotification,
                                                object: nil,
                                                userInfo:errorInfo(error: retunedBadDataError).toDict())
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
