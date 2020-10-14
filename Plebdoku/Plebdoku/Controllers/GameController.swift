//
//  GameController.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/13/20.
//

import Foundation

class GameController: ObservableObject {
    
    var gameFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    func startDate(_ game: Game) -> String {
        guard let startTime = game.startTime else { return "" }
        return gameFormatter.string(from: startTime)
    }
    
    func gameTime(_ game: Game) -> TimeInterval? {
        guard let startTime = game.startTime,
              let endTime = game.endTime else { return nil }
        return endTime.timeIntervalSince(startTime)
    }
    
    func time(_ game: Game) -> String? {
        guard let gameTime = gameTime(game) else { return nil }
        return String(format: "%.2f s", gameTime)
    }
    
    func score(_ game: Game) -> Int {
        guard let gameTime = gameTime(game) else { return 0 }
        return Int(1000 * pow(0.5, 0.5 * gameTime))
    }
    
}
