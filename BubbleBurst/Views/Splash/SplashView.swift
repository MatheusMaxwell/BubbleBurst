//
//  SplashView.swift
//  BubbleBurst
//
//  Created by Matheus Maxwell Meireles on 14/09/22.
//

import SwiftUI

struct SplasView: View {

    @ObservedObject private var model: SplashViewModel

    init(model: SplashViewModel) {
        self.model = model
    }
    
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                Text("BubbleBurst").bold().font(Font.largeTitle).foregroundColor(Color.white)
                if model.bindings.isCallButtonPlay.wrappedValue {
                    Button(action: model.callHomeView){
                        Text("JOGAR")
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(Color.gray.opacity(0.3)))
                    Text("Seu recorde é: \(model.getStoreRecord())")
                        .foregroundColor(Color.white)
                    
                }
            }
            NavigationLink(
                destination: HomeView(model: .init()),
                isActive: model.bindings.isNavigationToHome,
                label: {}
            )
            
            Group{
                createCircle(size: 100, x: 0, y: 30, color: Color.green)
                createCircle(size: 100.0, x: 792, y: 365, color: Color.red)
                createCircle(size: 60.0, x: 200, y: 180, color: Color.yellow)
                createCircle(size: 80.0, x: 600, y: 250, color: Color.blue)
                createCircle(size: 150.0, x: 100, y: 300, color: Color.blue)
                createCircle(size: 90.0, x: 700, y: 100, color: Color.yellow)
                createCircle(size: 60.0, x: 400, y: 43, color: Color.red)
                createCircle(size: 100.0, x: 400, y: 350, color: Color.green)
            }
            

        }
        .onAppear{
            model.callButtonPlay()
        }
    }
    
    func createCircle(size: CGFloat, x: CGFloat, y: CGFloat, color: Color) -> some View {
        
        return Circle().foregroundColor(color).frame(width: size, height: size).position(x: x, y: y)
    }
}

struct SplasView_Previews: PreviewProvider {
    static var previews: some View {
        SplasView(model: .init())
    }
}
