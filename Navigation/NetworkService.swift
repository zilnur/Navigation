//
//  NetworkService.swift
//  Navigation
//
//  Created by Ильнур Закиров on 08.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

struct NetworkService {
    
    func startURLSession(address: String) {
        
        if let url = URL(string: address) {
            
            let req = URLRequest(url: url)
            
            let session = URLSession.shared.dataTask(with: req) { data, response, error in
                if let uData = data {
                    if let answer = String(data: uData, encoding: .utf8) {
                        print("data is\(answer)")
                    }
                }
                if let uResponse = response as? HTTPURLResponse {
                    print("response is \(uResponse.statusCode) & \(uResponse.allHeaderFields)")
                }
                
                guard let uError = error else {return}
                print("Error is \(uError.localizedDescription)")
            }
            session.resume()
        }
    }
}

enum AppConfiguration: String, CaseIterable {
    
    case url1 = "https://swapi.dev/api/people/8"
    case url2 = "https://swapi.dev/api/starships/3"
    case url3 = "https://swapi.dev/api/planets/5"
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case "https://swapi.dev/api/people/8":
            self = .url1
        case "https://swapi.dev/api/starships/3":
            self = .url2
        default :
            self = .url3
        }
}
}
