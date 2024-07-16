//
//  PRFetchDataViewModel.swift
//  Nano3_Gymbro
//
//  Created by Christian Gunawan on 15/07/24.
//


import Foundation
import SwiftData

class DataManager: ObservableObject {
    @Published var cards: [Card] = []

    init() {
        fetchCards()
    }

    func fetchCards() {
        let exerciseNames = ExerciseNameRepository().getAllExerciseNames()

        var newCards: [Card] = []

        for exerciseName in exerciseNames {
            for exercisePR in exerciseName.sortedListPR {
                let card = Card(
                    id: UUID(),
                    title: exerciseName.name,
                    detail: "", // Add any detail if necessary
                    date: exercisePR.date,
                    weight: exercisePR.value
                )
                newCards.append(card)
            }
        }

        cards = newCards
    }
}

