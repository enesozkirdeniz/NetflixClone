//
//  Extensions.swift
//  NetflixClone
//
//  Created by Enes Özkırdeniz on 26.09.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
