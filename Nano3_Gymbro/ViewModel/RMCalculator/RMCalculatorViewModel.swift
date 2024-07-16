//
//  RMCalculatorViewModel.swift
//  Nano3_Gymbro
//
//  Created by Dinda Ayu Syafitri on 11/07/24.
//

import Foundation
import SwiftData

class RMCalculatorViewModel: ObservableObject {
    @Published var oneRepMax: Double = 0.0
    @Published var sets: Double = 0
    @Published var reps: Double = 0

    func calculateRM(weight: Double, reps: Double, sets: Double, unit: String) {
        let e = M_E
        let exponent = -0.055 * reps
        let oneRepMax = (100 * weight) / (52.2 + (41.9 * pow(e, exponent)))

        self.reps = reps
        self.sets = sets
        self.oneRepMax = oneRepMax

        print(oneRepMax)
    }

    func calculateRMPercentWeight(percentage: Int) -> Double {
//        let weight = Measurement(value: oneRepMax.value * Double(percentage) / 100, unit: UnitMass.kilograms)
        let weight = oneRepMax * Double(percentage) / 100

        return weight
    }

    func calculateVolume(weight: Double) -> Double {
//        let volume = Measurement(value: weight * reps * sets, unit: UnitMass.kilograms)
        let volume = weight * reps * sets
        return volume
    }
}
