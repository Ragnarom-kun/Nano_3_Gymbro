//
//  ExerciseName.swift
//  inputExercise
//
//  Created by Shan Havilah on 10/07/24.
//

import Foundation
import SwiftData

@Model
class ExerciseName: Identifiable{
    
    var id: String
    var name: String
    @Relationship(deleteRule: .cascade) var listRM: [ExerciseRM]
    @Relationship(deleteRule: .cascade) var listPR: [ExercisePR]
    var RMBest: Double
    
    init(name: String, id: String, listRM: [ExerciseRM] = [], listPR: [ExercisePR] = [], RMBest: Double) {
        self.id = UUID().uuidString
        self.name = name
        self.listPR = listPR
        self.listRM = listRM
        self.RMBest = RMBest
    }
    
    var sortedListPR: [ExercisePR] {
        listPR.sorted { $0.date < $1.date }
    }

    var sortedListRM: [ExerciseRM] {
        listRM.sorted { $0.date < $1.date }
    }
}
