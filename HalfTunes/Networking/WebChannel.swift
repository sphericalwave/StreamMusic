//
//  WebChannel.swift
//  AudioWave
//
//  Created by Aaron Anthony on 2020-01-30.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation

// Exposed Contract for MOCK/Real
protocol Channel
{
    typealias HttpResponse = (Data?, URLResponse?, Error?) -> Void
    func transmit(_ request: URLRequest, callback: @escaping HttpResponse)
}

extension URLSession: Channel
{
    func transmit(_ request: URLRequest, callback: @escaping HttpResponse) {
        dataTask(with: request, completionHandler: callback)
    }
}

protocol Response { func resume() }
extension URLSessionDataTask: Response { }  //returns data to in app memory
