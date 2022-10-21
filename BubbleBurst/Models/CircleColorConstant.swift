//
//  CircleColor.swift
//  BubbleBurst
//
//  Created by Matheus Maxwell Meireles on 14/10/22.
//

import Foundation
import SwiftUI

struct CircleColorConstant {
    static let blue = 0
    static let red = 1
    static let green = 2
    static let yellow = 3
}

extension CircleColorConstant {
    static func getColor(colorConstant: Int) -> Color{
        switch(colorConstant){
            case blue: return Color.blue
            case red: return Color.red
            case green: return Color.green
            default: return Color.yellow
        }
    }

}


