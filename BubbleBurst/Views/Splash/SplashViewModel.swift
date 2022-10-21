//
//  SplashViewModel.swift
//  BubbleBurst
//
//  Created by Matheus Maxwell Meireles on 14/09/22.
//

import SwiftUI
import Combine

final class SplashViewModel: ObservableObject {
    @Published private(set) var state: SplashViewState
    
    init(initialState: SplashViewState = .init()) {
        state = initialState
    }

    var bindings: (
            isCallButtonPlay: Binding<Bool>,
            isNavigationToHome: Binding<Bool>
        ) {
            (
                isCallButtonPlay: Binding(to: \.state.isCallButtonPlay, on: self),
                isNavigationToHome: Binding(to: \.state.isNavigationToHome, on: self)
            )
        }
    
    func callButtonPlay(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
            self.state.isCallButtonPlay = true
        }
    }
    
    func callHomeView(){
        self.state.isNavigationToHome = true
    }
    
    func getStoreRecord() -> Int{
        let defaults = UserDefaults.standard
        
        return defaults.integer(forKey: "record")
    }

}
