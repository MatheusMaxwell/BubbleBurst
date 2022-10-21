//
//  Color.swift
//  BubbleBurst
//
//  Created by Matheus Maxwell Meireles on 14/10/22.
//

import SwiftUI


extension Color {
    static func randomColor() -> Color{
        let color = Int.random(in: 0..<4)
        return CircleColorConstant.getColor(colorConstant: color)
    }
    
    static func getColorName(color: Color) -> String {
        switch(color){
            case Color.green: return "verdes"
            case Color.red: return "vermelhas"
            case Color.blue: return "azuis"
            case Color.yellow: return "amarelas"
            default: return ""
        }
    }
    
    static func getColorIsMissing(colors: [Color]) -> String {
        if(!colors.contains(Color.green)){
            return "verdes"
        }
        if(!colors.contains(Color.red)){
            return "vermelhas"
        }
        if(!colors.contains(Color.blue)){
            return "azuis"
        }
        if(!colors.contains(Color.yellow)){
            return "amarelas"
        }
        
        return ""
    }
}


