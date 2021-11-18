//
//  Checker.swift
//  Navigation
//
//  Created by Ильнур Закиров on 10.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class Checker {
    
    static let shared = Checker()
    
    func check(login: String, pass: String) -> Bool {
        if login == "1" && pass == "1" {
            return true
        } else {
            return false
        }
    }
}
