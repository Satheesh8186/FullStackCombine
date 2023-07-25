//
//  FullStackCombineApp.swift
//  FullStackCombine
//
//  Created by satheesh kumar on 25/07/23.
//

import SwiftUI

@main
struct FullStackCombineApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SignupView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
