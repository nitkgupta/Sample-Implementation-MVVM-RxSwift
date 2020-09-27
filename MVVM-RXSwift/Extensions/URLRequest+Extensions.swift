//
//  URLSession+Extensions.swift
//  MVVM-RXSwift
//
//  Created by Nitkarsh Gupta on 27/09/20.
//

import Foundation
import RxSwift
import RxCocoa

struct Request<T> {
    let url: URL
}

extension URLRequest {
    
    static func loadData<T: Decodable>(_ request: Request<T>) -> Observable<T?> {
        return Observable.just(request).flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
            let urlRequest = URLRequest(url: request.url)
            return URLSession.shared.rx.response(request: urlRequest)
        }.map { response, data -> T? in
            if 200..<300 ~= response.statusCode {
                return try? JSONDecoder().decode(T.self, from: data)
            } else {
                throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
            }
        }.asObservable()
    }
    
}
