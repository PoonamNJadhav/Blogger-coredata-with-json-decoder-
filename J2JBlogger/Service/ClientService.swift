//
//  ClientService.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 17/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation

class ClientService : NSObject{
    
    static let shared = ClientService() //Singleton class object
   
    func fetchArticles(page:Int = 1,completion:@escaping (Result<Data?, Error?>) -> Void) {
        let urlString = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=\(page)&limit=10"
        guard let url = URL(string: urlString) else { return }
        NetworkManager.shared.fetchDataWith(url, completion:completion)
    }
}
