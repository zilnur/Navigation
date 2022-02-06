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

protocol LogInViewControllerDelegate {
    func logInCheck(logIn: String, pass: String) -> Bool
}

class LogInInspector: LogInViewControllerDelegate {
    func logInCheck(logIn: String, pass: String) -> Bool {
        return Checker.shared.check(login: logIn, pass: pass)
}
}

protocol LoginFactory {
    func loginFactory() -> LogInInspector
}

class NewLoginFactory: LoginFactory {
    func loginFactory() -> LogInInspector {
        return LogInInspector()
    }
}
