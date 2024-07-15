//
//  Formatter.swift
//  Nano3_Gymbro
//
//  Created by Dinda Ayu Syafitri on 15/07/24.
//

import Foundation

func formatDoubletoString(_ value: Double) -> String {
    return String(format: "%.2f", value)
}

func changeUnit(_ value: Double, _ to: String) -> String {
    if to == "lb" {
        let convertedValue = Measurement(value: value, unit: UnitMass.kilograms).converted(to: .pounds)
        let formattedValue = formatDoubletoString(convertedValue.value)
        return formattedValue
    } else {
        let value = Measurement(value: value, unit: UnitMass.kilograms)
        let formattedValue = formatDoubletoString(value.value)
        return formattedValue
    }
}
