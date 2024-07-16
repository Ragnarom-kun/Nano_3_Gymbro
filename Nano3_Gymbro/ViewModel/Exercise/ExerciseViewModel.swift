//
//  ExerciseViewModel.swift
//  inputExercise
//
//  Created by Shan Havilah on 12/07/24.
//

import Foundation
import SwiftData

class ExerciseViewModel: ObservableObject{
    @Published var showDetails: Bool = false
    @Published var activeExercise: ExerciseName?
    @Published var activePersenan: Double?
    @Published var activeBebanTambahan: Double?
    
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
    
//    func addArray(item: ExerciseName, PR: Double, RM: Double, context: ModelContext){
//        item.listPR.append(ExercisePR(value: PR, id: UUID().uuidString, date: Date()))
//        item.listRM.append(ExerciseRM(value: RM, id: UUID().uuidString, date: Date()))
//        
//        if(item.RMBest < RM){
//            item.RMBest = RM
//        }
//    }
    
    func addArrayPR(item: ExerciseName, PR: Double, context: ModelContext){
        item.listPR.append(ExercisePR(value: PR, id: UUID().uuidString, date: Date()))
    }
    
    func addArrayRM(item: ExerciseName, RM: Double, context: ModelContext){
        item.listRM.append(ExerciseRM(value: RM, id: UUID().uuidString, date: Date()))
        
        if(item.RMBest < RM){
            item.RMBest = RM
        }
    }
    
    func setActiveExercise(_ item: ExerciseName, context: ModelContext){
        self.activeExercise = item
    }
    
    func setShowDetails(_ value: Bool) {
        showDetails = value
    }
    
    func calculateTrainingPlan (RPE: Double) {
        let lastRM = activeExercise?.sortedListRM.last?.value
            if(RPE >= 1 && RPE <= 5){
                let x: Double = RPE
                let x1: Double = 1
                let x2: Double = 5
                let y1: Double = 10
                let y2: Double = 15
                
                let kiriAtas = x - x1
                let kiriBawah = x2 - x1
                let kananBawah = y2 - y1
                
                let bagianKiri = kiriAtas * kananBawah
                let bagianKanan = kiriBawah * y1
                
                let y = (bagianKiri + bagianKanan)/kiriBawah
                
                let bebanTambahan = ((lastRM ?? 1) * y)/100
                print("y = \(y)")
                print(bebanTambahan)
                print(bebanTambahan + (lastRM ?? 1))
                let ini = bebanTambahan + (lastRM ?? 1)
                
                activePersenan = y
                activeBebanTambahan = ini
            }
        
        else if(RPE >= 6 && RPE <= 7){
            let x: Double = RPE
            let x1: Double = 6
            let x2: Double = 7
            let y1: Double = 5
            let y2: Double = 10
            
            let kiriAtas = x - x1
            let kiriBawah = x2 - x1
            let kananBawah = y2 - y1
            
            let bagianKiri = kiriAtas * kananBawah
            let bagianKanan = kiriBawah * y1
            
            let y = (bagianKiri + bagianKanan)/kiriBawah
            
            let bebanTambahan = ((lastRM ?? 1) * y)/100
            print("y = \(y)")
            print(bebanTambahan)
            print(bebanTambahan + (lastRM ?? 1))
            let ini = bebanTambahan + (lastRM ?? 1)
            
            activePersenan = y
            activeBebanTambahan = ini
        }
        else if(RPE >= 8 && RPE <= 10){
            let x: Double = RPE
            let x1: Double = 8
            let x2: Double = 10
            let y1: Double = 2
            let y2: Double = 5
            
            let kiriAtas = x - x1
            let kiriBawah = x2 - x1
            let kananBawah = y2 - y1
            
            let bagianKiri = kiriAtas * kananBawah
            let bagianKanan = kiriBawah * y1
            
            let y = (bagianKiri + bagianKanan)/kiriBawah
            
            let bebanTambahan = ((lastRM ?? 1) * y)/100
            print("y = \(y)")
            print(bebanTambahan)
            print(bebanTambahan + (lastRM ?? 1))
            let ini = bebanTambahan + (lastRM ?? 1)
            
            activePersenan = y
            activeBebanTambahan = ini
        }
    }
    
}
