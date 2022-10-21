//
//  BubbleBurstApp.swift
//  BubbleBurst
//
//  Created by Matheus Maxwell Meireles on 14/09/22.
//

import SwiftUI

@main
struct BubbleBurstApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationView{
                SplasView(model: .init())
            }
            .navigationViewStyle(.stack)
        }
        
    }
}
