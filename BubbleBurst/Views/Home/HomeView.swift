//
//  ContentView.swift
//  BubbleBurst
//
//  Created by Matheus Maxwell Meireles on 14/09/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var model: HomeViewModel
    private var measure = Measure(screenSize: UIScreen.main.bounds)
    
    @Environment(\.presentationMode) var presentation
    
    init(model: HomeViewModel) {
        self.model = model
        self.model.setMeasure(measure: measure)
    }
    
    var body: some View {
        let maxQtdPerLine = measure.getMaxQtdPerLine()
        let maxQtdRow = measure.getMaxQtdRow()
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                HStack(){
                    if model.bindings.timeCount.wrappedValue != HomeViewState.INITIAL_STATE_TIME_COUNT{ Text("\(model.bindings.timeCount.wrappedValue)")
                    }
                    Spacer()
                    Text("Estoure as bolhas \(model.getDescriptionToAction()).")
                    Spacer()
                    Text("\(model.bindings.count.wrappedValue)")
                }
                .padding(20)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                    
                
                if !model.state.bubbleList.isEmpty {
                    Grid(alignment: .center){
                        ForEach((0..<maxQtdRow), id: \.self){ row in
                            GridRow{
                                ForEach((0..<maxQtdPerLine), id: \.self) { columnPositionItem in
                                    let position = maxQtdPerLine * row + columnPositionItem
                                    createCircle(position: position)
                                }
                            }
                        }
                        
                    }
                }
                
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .top)
            if model.bindings.victories.wrappedValue > 0{
                Text("\(model.bindings.victories.wrappedValue)")
                    .font(.system(size: 150))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .hiddenConditionally(isHidden: !model.bindings.showVictory.wrappedValue)
            }
        }
        .onAppear{
            model.createBubbleList()
        }
        .alert(isPresented: model.bindings.isShowError){
            Alert(
                title: Text("Você perdeu!"),
                message: Text(model.bindings.messageError.wrappedValue),
                primaryButton: .default(Text("Jogar Novamente")) {
                    model.restoreAlertMessage()
                    model.restoreList()
                },
                secondaryButton: .destructive(Text("Sair")){
                    model.restoreAlertMessage()
                    self.presentation.wrappedValue.dismiss()
                }
            )
        }
        .navigationBarBackButtonHidden()
    }
    
    
    
    func createCircle(position: Int) -> some View {
        let bubble = model.bindings.bubbleList.wrappedValue[position]
 
        return Circle()
            .fill(bubble.color)
            .frame(width: bubble.size, height: bubble.size)
            .padding(.trailing, 8)
            .padding(.leading, 8)
            .hiddenConditionally(isHidden: bubble.isClicked)
            .onTapGesture {
                if(model.colorsSelected.contains(bubble.color)){
                    model.incrementCount()
                    model.bindings.bubbleList.wrappedValue[position].isClicked = true
                    if(model.isFinishedClickBubbles()){
                        model.invalidadeTimer(isRestoreVictories: false)
                        model.restoreList()
                        model.incrementVictory()
                    }
                }
                else{
                    model.invalidadeTimer()
                    model.showAlertError()
                }
            }
            .id(bubble.id)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(model: .init())
    }
}
