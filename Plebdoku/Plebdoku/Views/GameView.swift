//
//  GameView.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import SwiftUI

struct GameView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @EnvironmentObject var sudokuController: SudokuController
    @EnvironmentObject var gameController: GameController
    
    @State private var showingSettings = false
    @State private var showingGames = false
    
    var settingsButton: some View {
        NavigationLink(destination: SettingsView(), isActive: $showingSettings) {
            Image(systemName: "gear")
                .imageScale(.large)
        }
        .onChange(of: showingSettings) { showingSettings in
            sudokuController.timerIsRunning = !showingSettings
        }
    }
    
    var gamesButton: some View {
        NavigationLink(destination: GamesView(), isActive: $showingGames) {
            Text("History")
        }
        .onChange(of: showingGames) { showingGames in
            sudokuController.timerIsRunning = !showingGames
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
                        Text("You're winner! \(sudokuController.scoreString(gameController: gameController))")
                    } else {
                        Text("You're a pleb.")
                    }
                } else {
                    Text("Plebdoku")
                }
                Button("New Game") {
                    sudokuController.newGame(context: moc)
                }
                GeometryReader { _ in
                    // For some reason the numpad will only
                    // resize if it's in a geometry reader.
                    NumPad()
                }
            }
        }
        .navigationTitle("Plebdoku")
        .navigationBarItems(leading: gamesButton, trailing: settingsButton)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameView()
                .environmentObject(SudokuController(context: PersistenceController.preview.container.viewContext))
                .environmentObject(GameController())
        }
    }
}
