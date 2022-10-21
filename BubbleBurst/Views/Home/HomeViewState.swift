//
//  HomeViewState.swift
//  BubbleBurst
//
//  Created by Matheus Maxwell Meireles on 14/10/22.
//


struct HomeViewState {
    var count = 0
    var bubbleList = [Bubble]()
    var messageError = "Seu tempo acabou."
    var timeCount = INITIAL_STATE_TIME_COUNT
    var victories = 0
    var showVictory = false
    
    static let INITIAL_STATE_TIME_COUNT = 1000
}

extension HomeViewState {
    
    var isShowError: Bool {
        get {
            return timeCount == 0
        }
        set(newValue) {
            timeCount = 0
        }
    }
    
}
