//
//  RMCalculatorViewModel.swift
//  Nano3_Gymbro
//
//  Created by Dinda Ayu Syafitri on 11/07/24.
//

import Foundation

class RMCalculatorViewModel: ObservableObject {
    @Published var oneRepMax: Double = 0.0

    func calculateRM(weight: Double, reps: Double) -> Double {
        let e = M_E
        let exponent = -0.055 * reps
        let oneRepMax = (100 * weight) / (52.2 + (41.9 * pow(e, exponent)))

        self.oneRepMax = oneRepMax
        return oneRepMax
    }
}
