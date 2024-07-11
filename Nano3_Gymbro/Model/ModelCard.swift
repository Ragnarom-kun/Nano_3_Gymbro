//
//  ModelCard.swift
//  Nano3_Gymbro
//
//  Created by Christian Gunawan on 11/07/24.
//

import SwiftUI
import SwiftData

struct Card: Identifiable {
    let id: UUID
    let title: String
    let detail: String
    let date: Date
    let weight: Int
    
    
}
