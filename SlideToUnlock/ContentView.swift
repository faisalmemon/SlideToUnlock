//
//  ContentView.swift
//  SlideToUnlock
//
//  Created by Faisal Memon on 22/10/2021.
//

import SwiftUI

extension View {
    public func gradientForeground(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        self.overlay(LinearGradient(gradient: Gradient(stops: [ .init(color: colors[0], location: 0.33),.init(color: colors[1], location: 0.475),
                                                                  .init(color: colors[0], location: 0.525)]),
                                    startPoint: startPoint,
                                    endPoint: endPoint))
            .mask(self)
    }
   
   
}

struct SlideToUnlockStyle: ButtonStyle {
    
    @State var startPoint = UnitPoint(x: -2, y: 0)
    @State var endPoint = UnitPoint(x: 1, y: 0)

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .gradientForeground(colors: [Color.init(red: 78/255, green: 78/255, blue: 78/255), Color.accentColor], startPoint: startPoint, endPoint: endPoint).padding(.trailing, 28)
            .onAppear() {
                withAnimation (Animation.easeInOut(duration: 3.6).repeatForever(autoreverses: false)){
                        self.endPoint = UnitPoint(x: 2, y: 0)
                        self.startPoint = UnitPoint(x: 1, y: 1)
                }
            }
    }
}

struct ContentView: View {
    var body: some View {

        Button("Slide to unlock styled button")  {
            print("Button pressed")
        }.buttonStyle(SlideToUnlockStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
