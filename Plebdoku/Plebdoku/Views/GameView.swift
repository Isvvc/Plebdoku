//
//  GameView.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var sudokuController: SudokuController
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                PlebdokuView()
                Spacer()
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
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
