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

    func addRM(rm: Double, context: ModelContext) {}

    func calculateRM(weight: Double, reps: Double, sets: Double) {
        let e = M_E
        let exponent = -0.055 * reps
        let oneRepMax = (100 * weight) / (52.2 + (41.9 * pow(e, exponent)))

        self.reps = reps
        self.sets = sets
        self.oneRepMax = oneRepMax
    }

    func calculateRMPercentWeight(percentage: Int) -> Double {
        let weight = Measurement(value: oneRepMax * Double(percentage) / 100, unit: UnitMass.kilograms).value

        return weight
    }

    func calculateVolume(weight: Double) -> Double {
        let volume = weight * reps * sets
        return volume
    }
}
