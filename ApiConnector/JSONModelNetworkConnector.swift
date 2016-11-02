//
//  JSONModelNetworkConnector.swift
//  ApiConnector
//
//  Created by Oleksii on 02/11/2016.
//  Copyright © 2016 WeAreReasonablePeople. All rights reserved.
//

import RxSwift
import Alamofire
import SwiftyJSON
import SwiftyJSONModel

public extension DataRequestType {
    public func jsonObservable() -> Observable<JSON> {
        return responseObservable().map({ JSON(data: $0) })
    }
    
    public func modelObservable<T: JSONInitializable>() -> Observable<T> {
        return jsonObservable().map({ try T(json: $0) })
    }
    
    public func modelObservable<T: JSONInitializable>() -> Observable<[T]> {
        return jsonObservable().map({ try $0.arrayValue.map({ try T(json: $0) }) })
    }
}

public extension ApiConnectionType {
    public func requestData(with model: JSONRepresentable? = nil, at endpoint: Router, headers: HTTPHeaders? = nil) -> Request {
        return requestData(with: model?.jsonValue, at: endpoint, headers: headers)
    }
    
    public func requestData(with json: JSON? = nil, at endpoint: Router, headers: HTTPHeaders? = nil) -> Request {
        return requestData(with: json.flatMap({ try? $0.rawData() }), at: endpoint, headers: headers)
    }
    
    public func requestObservable<T: JSONInitializable>(with model: JSONRepresentable? = nil, at endpoint: Router, headers: HTTPHeaders? = nil) -> Observable<T> {
        return requestData(with: model, at: endpoint, headers: headers).validate().modelObservable()
    }
    
    public func requestObservable<T: JSONInitializable>(with model: JSONRepresentable? = nil, at endpoint: Router, headers: HTTPHeaders? = nil) -> Observable<[T]> {
        return requestData(with: model, at: endpoint, headers: headers).validate().modelObservable()
    }
}