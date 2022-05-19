//
//  Config.swift
//  Navigation
//
//  Created by Ильнур Закиров on 23.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}

extension Int {
    func convert() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        guard let word = formatter.string(from: NSNumber(value: self)) else {return ""}
        let string = (word.first?.uppercased())! + word.dropFirst()
        return string
    }
}
