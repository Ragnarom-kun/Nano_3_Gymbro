//
//  Nano3_GymbroApp.swift
//  Nano3_Gymbro
//
//  Created by Romi Fadhurohman Nabil on 08/07/24.
//

import SwiftUI

@main
struct Nano3_GymbroApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: [ExerciseName.self, ExercisePR.self, ExerciseRM.self])
    }
}
