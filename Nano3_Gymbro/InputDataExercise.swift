//
//  InputDataExercise.swift
//  Nano3_Gymbro
//
//  Created by Romi Fadhurohman Nabil on 16/07/24.
//

import Foundation
import SwiftData

extension ExerciseName {
    static let squat = ExerciseName(name: "Squat", id: UUID().uuidString, RMBest: 0.0)
    static let benchpress = ExerciseName(name: "Bench Press", id: UUID().uuidString, RMBest: 0.0)
    static let deadlift = ExerciseName(name: "Deadlift", id: UUID().uuidString, RMBest: 0.0)

    static func insertSampleData(modelContext: ModelContext) {
        let exercisesToInsert = [
            squat,
            benchpress,
            deadlift
        ]

        for exercise in exercisesToInsert {
            if !doesExerciseExist(name: exercise.name, modelContext: modelContext) {
                modelContext.insert(exercise)
            }
        }
    }

    static func doesExerciseExist(name: String, modelContext: ModelContext) -> Bool {
        let fetchDescriptor = FetchDescriptor<ExerciseName>(
            predicate: #Predicate { $0.name == name }
        )
        
        do {
            let results = try modelContext.fetch(fetchDescriptor)
            return !results.isEmpty
        } catch {
            print("Fetch error: \(error.localizedDescription)")
            return false
        }
    }

    static func reloadSampleData(modelContext: ModelContext) {
        insertSampleData(modelContext: modelContext)
    }
}

