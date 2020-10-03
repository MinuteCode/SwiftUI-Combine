//
//  BullsEyeViewModel.swift
//  ReactiveTuto
//
//  Created by Benjamin Ameur on 03/10/2020.
//  Copyright © 2020 Benjamin Ameur. All rights reserved.
//

import Foundation
import Combine

class BullsEyeViewModel: ObservableObject {
    @Published var rTarget: Double = Double.random(in: 0...1)
    @Published var gTarget: Double = Double.random(in: 0...1)
    @Published var bTarget: Double = Double.random(in: 0...1)
    
    var cancellables: Set<AnyCancellable> = []
    
    func getNewValues() {
        NumberApiCombine.randomNumber(min: 0, max: 255, count: 3)
        .publish()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished: break
            case .failure(let error):
                print(error)
            }
        }) { (values) in
            self.rTarget = Double(values[0]) / 255
            self.gTarget = Double(values[1]) / 255
            self.bTarget = Double(values[2]) / 255
        }
        .store(in: &cancellables)
    }
    
    func cancel(_ cancellable: AnyCancellable) {
        cancellable.cancel()
    }
    
    func cancelAll() {
        cancellables.forEach { (cancellable) in
            cancel(cancellable)
        }
    }
}
