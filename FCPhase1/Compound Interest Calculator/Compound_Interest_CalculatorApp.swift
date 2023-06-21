//
//  Compound_Interest_CalculatorApp.swift
//  Compound Interest Calculator
//
//  Created by Arfaz Hussain on 2023-04-15.
//

import SwiftUI

@main
struct Compound_Interest_CalculatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
