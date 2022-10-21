//
//  HomeViewModel.swift
//  BubbleBurst
//
//  Created by Matheus Maxwell Meireles on 14/10/22.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    @Published private(set) var state: HomeViewState
    
    init(initialState: HomeViewState = .init()) {
        state = initialState
    }
    
    var colorsSelected = [Color]()
    
    var countTotalBubbles = 0
    
    var measure: Measure? = nil
    
    private var timer = Timer()
    
    var bindings: (
            isShowError: Binding<Bool>,
            count: Binding<Int>,
            bubbleList: Binding<[Bubble]>,
            timeCount: Binding<Int>,
            messageError: Binding<String>
        ) {
            (
                isShowError: Binding(to: \.state.isShowError, on: self),
                count: Binding(to: \.state.count, on: self),
                bubbleList: Binding(to: \.state.bubbleList, on: self),
                timeCount: Binding(to: \.state.timeCount, on: self),
                messageError: Binding(to: \.state.messageError, on: self)
            )
        }
    
    
    func setMeasure(measure: Measure){
        self.measure = measure
    }
    
    func createBubbleList(){
        let listSize = self.measure!.getMaxQtdRow() * self.measure!.getMaxQtdPerLine()
        var list = [Bubble]()
        
        for i in 1...listSize {
            list.append(Bubble(id: i, color: Color.randomColor(), isClicked: false, size: CGFloat(self.measure!.getSize())))
        }
        
        self.colorsSelected = self.sortColorsToCLick()
        self.state.bubbleList = list
        self.countTotalBubblesFunc()
        self.startTimer()
    }
    
    func showAlertError(){
        self.state.messageError = "Você clicou em uma bolha errada."
        self.state.isShowError = true
    }
    
    func restoreAlertMessage(){
        self.state.messageError = "Seu tempo acabou."
    }
    
    func incrementCount(){
        self.state.count += 1
    }
    
    private func restoreCount(){
        self.state.count = 0
    }
    
    func restoreList(){
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)){
            self.restoreCount()
            self.createBubbleList()
        }
    }
    
    private func sortColorsToCLick() -> [Color] {
        let color = Color.randomColor()
        let isClickedOrIsNotClicked = Bool.random()
        var colors = [Color]()
        
        if(isClickedOrIsNotClicked){
            colors.append(color)
            return colors
        }
        else{
            colors.append(Color.green)
            colors.append(Color.blue)
            colors.append(Color.red)
            colors.append(Color.yellow)
            colors.removeAll{
                $0 == color
            }
            return colors
        }
    }
    
    func getDescriptionToAction() -> String {
        let colors = self.colorsSelected
        if(colors.count == 1){
            return Color.getColorName(color: colors[0])
        }
        else{
            return "não \(Color.getColorIsMissing(colors: colors))"
        }
    }
    
    private func countTotalBubblesFunc(){
        var countBubbles = 0
        colorsSelected.forEach{ color in
            self.state.bubbleList.forEach{ bubble in
                if(color == bubble.color){
                    countBubbles += 1
                }
            }
        }
        self.countTotalBubbles = countBubbles
    }
    
    func isFinishedClickBubbles() -> Bool {
        if(self.countTotalBubbles == self.state.count){
            return true
        }
        else{
            return false
        }
    }
    
    private func startTimer(){
        if(countTotalBubbles < 4){
            self.state.timeCount = countTotalBubbles
        }
        else if(countTotalBubbles < 8){
            self.state.timeCount = countTotalBubbles + 1
        }
        else if(countTotalBubbles < 12){
            self.state.timeCount = countTotalBubbles - 3
        }
        else{
            self.state.timeCount = countTotalBubbles - 5
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.state.timeCount -= 1
            if(self.state.timeCount == 0){
                timer.invalidate()
            }
        }
    }
    
    func invalidadeTimer(){
        timer.invalidate()
    }
}
