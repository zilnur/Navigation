//
//  NetworkService.swift
//  Navigation
//
//  Created by Ильнур Закиров on 08.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

struct Planet: Codable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents
        case films
        case created
        case edited
        case url
    }
}

struct NetworkService {
    
    func startURLSession(label: UILabel) {
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/7") {
            
            let req = URLRequest(url: url)
            
            let session = URLSession.shared.dataTask(with: req) { data, response, error in
                if let uData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: uData, options: [])
                        
                        if let dict = json as? [String:Any],
                           let text = dict["title"] as? String {
                            DispatchQueue.main.async {
                                label.text = text
                            }
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            session.resume()
        }
    }
    
    func decode(label: UILabel) {
        
        if let url = URL(string: "https://swapi.dev/api/planets/1") {
            
            let session = URLSession.shared.dataTask(with: url) { data,response, error in
                if let uData = data {
                    do {
                        let answer = try JSONDecoder().decode(Planet.self, from: uData)
                        DispatchQueue.main.async {
                            label.text = answer.name
                        }
                    } catch let error {
                        print("Error is \(error)")
                    }
                }
            }
            session.resume()
        }
    }
}


