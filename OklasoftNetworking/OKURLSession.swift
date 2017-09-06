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

open class OKURLSession: URLSession  {
    
    public var OKdelegate: OKURLSessionDelegate?
    public static let OKShared: OKURLSession = OKURLSession()
    
    public func getReturnedDataFrom(url: URL) {
        let task: URLSessionDataTask = self.dataTask(with: url) { (data, responce, error) in
            unowned let unownedSelf: OKURLSession = self
            if let foundError:Error = error {
                unownedSelf.OKdelegate?.receavedNetworkError(error: foundError)
                return
            }
            guard let foundData: Data = data,
                let metaData: URLResponse = responce else {
                    unownedSelf.OKdelegate?.receavedNetworkError(error: retunedBadDataError)
                    return
            }
            let httpInfo: HTTPInfo = HTTPInfo(key: userInfoKey,
                                              data: foundData,
                                              metaData: metaData)
            unownedSelf.OKdelegate?.receavedData(httpInfo: httpInfo)
        }
        task.resume()
    }
    
    public func getReturnedDataFrom(url: URL, completion: @escaping networkCompletion) {
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url, completionHandler: completion)
        task.resume()
    }
}

public protocol OKURLSessionDelegate {
    func receavedNetworkError(error: Error)
    func receavedData(httpInfo: HTTPInfo)
}
