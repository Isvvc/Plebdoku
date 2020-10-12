//
//  ContentView.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        GameView()
            .environmentObject(SudokuController())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
