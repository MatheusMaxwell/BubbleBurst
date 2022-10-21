//
//  Measure.swift
//  BubbleBurst
//
//  Created by Matheus Maxwell Meireles on 14/10/22.
//

import Foundation

struct Measure {
    var maxCircleSize = 0
    var minCircleSize = 0
    var maxX = 0
    var minX = 10
    var maxY = 0
    var minY = 0
    var maxQtdPerLine = 0
    var maxQtdRow = 0
    
    init(screenSize: CGRect){
        self.maxCircleSize = Int(screenSize.height * 0.3)
        self.minCircleSize = Int(screenSize.height * 0.05)
        self.maxX = Int(screenSize.width * 0.85)
        self.minY = Int(screenSize.height * 0.1)
        self.maxY = Int(screenSize.height * 0.85)
        self.maxQtdPerLine = Int(screenSize.width / CGFloat(self.maxCircleSize))
        self.maxQtdRow = Int(screenSize.height / CGFloat(self.maxCircleSize))
    }
}

extension Measure {
    
    func getMaxQtdRow () -> Int {
        return maxQtdRow
    }
    
    func getMaxQtdPerLine () -> Int {
        return maxQtdPerLine
    }
   
    func getSize() -> Int{
        return Int.random(in: minCircleSize..<maxCircleSize)
    }
    
    func getY() -> Int {
        return Int.random(in: minY..<maxY) + (maxCircleSize/2)
    }
    
    func getX() -> Int {
        return Int.random(in: minX..<maxX) + (maxCircleSize/2)
    }
}
