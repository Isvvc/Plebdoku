//
//  GameView.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var sudokuController: SudokuController
    
    @State private var showingSettings = false
    
    var settingsButton: some View {
        NavigationLink(destination: SettingsView(), isActive: $showingSettings) {
                Image(systemName: "gear")
                    .imageScale(.large)
        }
        .onChange(of: showingSettings) { showingSettings in
            sudokuController.timerIsRunning = !showingSettings
        }
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                PlebdokuView()
                Spacer()
                TimerView()
                if let winner = sudokuController.winner {
                    if winner {
                        Text("You're winner!")
                    } else {
                        Text("You're a pleb.")
                    }
                } else {
                    Text("Plebdoku")
                }
                Button("New Game") {
                    sudokuController.generatePlebdoku()
                }
                NumPad()
            }
        }
        .navigationTitle("Plebdoku")
        .navigationBarItems(trailing: settingsButton)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
