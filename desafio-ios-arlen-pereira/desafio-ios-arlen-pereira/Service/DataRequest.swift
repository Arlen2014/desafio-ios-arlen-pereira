//
//  DataRequest.swift
//  desafio-ios-arlen-pereira
//
//  Created by Arlen Ricardo Pereira on 29/02/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest
{
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T>
    {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            guard let data = data else
            {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self
    {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responsePersons(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<PersonListModel>) -> Void) -> Self
    {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseHQ(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<PersonHQModel>) -> Void) -> Self
    {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

