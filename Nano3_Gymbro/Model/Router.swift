//
//  Router.swift
//  Nano3_Gymbro
//
//  Created by Romi Fadhurohman Nabil on 11/07/24.
//

import Foundation


class Router: ObservableObject {
    @Published var path: [Destination] = []

    enum Destination: String, Hashable {
        case LineChart
    }

    static let shared: Router = .init()
}
