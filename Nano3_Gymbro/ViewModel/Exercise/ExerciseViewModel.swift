//
//  ExerciseViewModel.swift
//  inputExercise
//
//  Created by Shan Havilah on 12/07/24.
//

import Foundation
import SwiftData

class ExerciseViewModel: ObservableObject{
    
    @Published var activeExercise: ExerciseName?
    
    func addItem(name: String, id: String, listRM: [ExerciseRM] = [], listPR: [ExercisePR] = [], RMBest: Double, context: ModelContext){
        let item = ExerciseName(name: name, id: id, listRM: listRM, listPR: listPR, RMBest: 0)
        context.insert(item)
    }
    
    func deleteItem(_ item: ExerciseName, context: ModelContext) {
        if activeExercise == item{
            activeExercise = nil
        }
        context.delete(item)
    }
    
    func addArray(item: ExerciseName, PR: Double, RM: Double, context: ModelContext){
        item.listPR.append(ExercisePR(value: PR, id: UUID().uuidString, date: Date()))
        item.listRM.append(ExerciseRM(value: RM, id: UUID().uuidString, date: Date()))
        
        if(item.RMBest < RM){
            item.RMBest = RM
        }
    }
    
    func setActiveExercise(_ item: ExerciseName, context: ModelContext){
        self.activeExercise = item
    }
}
