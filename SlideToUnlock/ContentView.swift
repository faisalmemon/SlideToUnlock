//
//  ContentView.swift
//  SlideToUnlock
//
//  Created by Faisal Memon on 22/10/2021.
//  Concept & original work taken from OldOS, Zane Kleinberg
//  https://github.com/zzanehip/The-OldOS-Project
//

import SwiftUI

extension View {
    
    public func gradientForeground(from: Color, to: Color, startPoint: UnitPoint, endPoint: UnitPoint) -> some View {

        self.overlay(
            LinearGradient(
                gradient: Gradient(
                    stops: [ .init(color: from, location: 0.33),
                             .init(color: to,   location: 0.475),
                             .init(color: from, location: 0.525)]),
                startPoint: startPoint,
                endPoint: endPoint))
            .mask(self)
    }
}

struct SlideToUnlockStyle: ButtonStyle {
    
    // In our co-ordinate scheme, Text is on the unit range [0..1]
    // -2...[0..1]...2
    // The animation is animating the (start, end) tuple (-2, 1) -> (1, 2)
    @State var startPoint = UnitPoint(x: -2, y: 0)
    @State var endPoint = UnitPoint(x: 1, y: 0)
    
    let grey = Color.init(red: 78/255, green: 78/255, blue: 78/255)

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .gradientForeground(from: grey, to: Color.accentColor, startPoint: startPoint, endPoint: endPoint).padding(.trailing, 28)
            .onAppear() {
                withAnimation (Animation.easeInOut(duration: 3.6).repeatForever(autoreverses: false)){
                        self.endPoint = UnitPoint(x: 2, y: 0)
                        self.startPoint = UnitPoint(x: 1, y: 0)
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
