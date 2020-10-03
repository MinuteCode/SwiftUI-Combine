//
//  ContentView.swift
//  ReactiveTuto
//
//  Created by Benjamin Ameur on 03/10/2020.
//  Copyright © 2020 Benjamin Ameur. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject private var bullsEyeViewModel = BullsEyeViewModel()
    
    @State var rGuess: Double = 0.5
    @State var gGuess: Double = 0.5
    @State var bGuess: Double = 0.5
    
    @State var showAlert = false
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Rectangle()
                        .foregroundColor(
                            Color(
                                red: bullsEyeViewModel.rTarget,
                                green: bullsEyeViewModel.gTarget,
                                blue: bullsEyeViewModel.bTarget, opacity: 1
                            )
                        )
                    Text("Match this color")
                }
                VStack {
                    Rectangle()
                        .foregroundColor(
                            Color(
                                red: rGuess,
                                green: gGuess,
                                blue: bGuess,
                                opacity: 1
                            )
                        )
                    HStack {
                        Text("R: \(Int(rGuess * 255.0))")
                        Text("G: \(Int(gGuess * 255.0))")
                        Text("B: \(Int(bGuess * 255.0))")
                    }
                }
            }
            
            VStack {
                Button(action: {
                    self.showAlert = true
                }) {
                    Text("Hit Me !")
                }
                .alert(isPresented: $showAlert) { () -> Alert in
                    return Alert(title: "Score".toText, message: "\(computeScore())".toText)
                }
                .padding()
                
                Button(action: {
                    self.bullsEyeViewModel.getNewValues()
                }) {
                    Text("Reset")
                }
            }
            
            VStack {
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }
        }
    }
    
    func computeScore() -> Int {
        let rDiff = bullsEyeViewModel.rTarget - rGuess
        let gDiff = bullsEyeViewModel.gTarget - gGuess
        let bDiff = bullsEyeViewModel.bTarget - bGuess
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        return Int((1 - diff) * 100 + 0.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    var body: some View {
        HStack {
            Text("0")
                .foregroundColor(textColor)
            Slider(value: $value)
            Text("255")
                .foregroundColor(textColor)
        }.padding()
    }
}
