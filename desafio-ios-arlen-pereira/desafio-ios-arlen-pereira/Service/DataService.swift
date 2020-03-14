//
//  DataService.swift
//  desafio-ios-arlen-pereira
//
//  Created by Arlen Ricardo Pereira on 29/02/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift

enum APIError: String, Error
{
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case operationFail = "The operation couldn’t be completed."
}

protocol DataServiceProtocol
{
    func requestFetchPersons(offset: Int, completion: @escaping (_ success: Bool, _ persons: PersonListModel?, _ error: APIError?) -> ())
    func requestFetchPersonHQ(personId: Int, offset: Int, completion: @escaping (_ success: Bool, _ persons: PersonHQModel?, _ error: APIError?) -> ())
}

class DataService: DataServiceProtocol
{
    static let shared = DataService()
    
    func requestFetchPersons(offset: Int, completion: @escaping (_ success: Bool, _ persons: PersonListModel?, _ error: APIError?) -> ())
    {
        let urlBase = "\(MARVEL_API)\(MARVEL_API_CHARACTERS)"
        var param = [String: Any]()
        let timeStamp = Int(Date().timeIntervalSince1970)
        param["ts"] = timeStamp
        param["apikey"] = MARVEL_PUBLIC_KEY
        param["hash"] = getHash(ts: timeStamp)
        param["limit"] = MARVEL_LIMIT
        param["offset"] = offset
        let headers = ["Content-Type":"application/json", "Accept":"application/json"]
        
        Alamofire.request(urlBase, method: .get, parameters: param, encoding: URLEncoding.default, headers: headers).responsePersons { (response) in

            if let error = response.error
            {
                completion(false, nil, APIError.operationFail)
                print(error)
                return
            }

            if let persons = response.result.value
            {
                completion(true, persons, nil)
                return
            }
        }
    }
    
    func requestFetchPersonHQ(personId: Int, offset: Int, completion: @escaping (_ success: Bool, _ persons: PersonHQModel?, _ error: APIError?) -> ())
    {
        let urlBase = "\(MARVEL_API)\(MARVEL_API_CHARACTERS)/\(personId)/comics"
        var param = [String: Any]()
        let timeStamp = Int(Date().timeIntervalSince1970)
        param["ts"] = timeStamp
        param["apikey"] = MARVEL_PUBLIC_KEY
        param["hash"] = getHash(ts: timeStamp)
        param["limit"] = MARVEL_LIMIT
        param["offset"] = offset
        param["orderBy"] = MARVEL_ORDERBY
        let headers = ["Content-Type":"application/json", "Accept":"application/json"]
        
        Alamofire.request(urlBase, method: .get, parameters: param, encoding: URLEncoding.default, headers: headers).responseHQ { response in

            if let error = response.error
            {
                completion(false, nil, APIError.operationFail)
                print(error)
                return
            }

            if let persons = response.result.value
            {
                completion(true, persons, nil)
                return
            }
        }
    }
    
    private func getHash(ts: Int) -> String {
        let hash = "\(ts)\(MARVEL_PRIVATE_KEY)\(MARVEL_PUBLIC_KEY)"
        return hash.md5()
    }
}

