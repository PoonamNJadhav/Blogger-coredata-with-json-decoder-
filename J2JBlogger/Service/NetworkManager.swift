//
//  NetworkManager.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 19/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation

enum Result <T, E>{
    
    case success(T)
    case error(E)
}

protocol NetworkManagerProtocol {
    
    func fetchDataWith(_ url:URL,completion: @escaping (Result<Data?, Error?>) -> Void)
}

class NetworkManager: NSObject{
    
    // Create a singleton
    private override init() {
        
    }
    static let shared = NetworkManager()
    
    
}

extension NetworkManager: NetworkManagerProtocol{
    
    func fetchDataWith(_ url:URL,completion: @escaping (Result<Data?, Error?>) -> Void) {
    
       URLSession.shared.dataTask(with: url) { (data, resp, err) in
               if let err = err {
                                 completion(.error(err))
                                  return
                              }
                //response parsing
                
                guard let data = data else { return }
                do {
                    completion(.success(data))
                } catch let jsonErr {
                    completion(.error(jsonErr))
                }
        
                }.resume()
    }
    
    
}
