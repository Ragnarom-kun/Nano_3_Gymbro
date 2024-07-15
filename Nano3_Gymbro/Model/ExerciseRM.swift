//
//  ExerciseRM.swift
//  inputExercise
//
//  Created by Shan Havilah on 10/07/24.
//

import Foundation
import SwiftData

@Model
class ExerciseRM: Identifiable{
    var id: String
    var value: Double
    var date: Date
    
    init(value: Double, id: String, date: Date){
        self.id = UUID().uuidString
        self.value = value
        self.date = date
    }
}
