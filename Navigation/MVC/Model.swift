//
//  Model.swift
//  Navigation
//
//  Created by Ильнур Закиров on 21.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct Model {
    
    private let pass = "Пароль"
    
    func check(word: String?) -> Bool {
        if word == pass {
            return true
        }
        return false
    }
}
