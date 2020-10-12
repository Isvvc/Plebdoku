//
//  PlebdokuApp.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import SwiftUI

@main
struct PlebdokuApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
