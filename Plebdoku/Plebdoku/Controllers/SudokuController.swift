//
//  SudokuController.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import CoreData

class SudokuController: ObservableObject {
    private let defaultSudoku: [[Int8]] = [
        [9,2,7,4,3,1,5,8,6],
        [4,5,6,9,2,8,7,3,1],
        [3,1,8,7,6,5,9,4,2],
        [6,4,1,8,5,2,3,9,7],
        [8,7,3,1,4,9,2,6,5],
        [2,9,5,6,7,3,4,1,8],
        [7,6,9,5,8,4,1,2,3],
        [5,3,4,2,1,6,8,7,9],
        [1,8,2,3,9,7,6,5,4]
    ]
    
    @Published var plebdoku: [[Int8]]
    @Published var x: Int
    @Published var y: Int
    @Published var timerIsRunning = false
    @Published var game: Game?
    
    var missing: Int16 {
        Int16(plebdoku[y][x])
    }
    
    var gameInProgress: Bool {
        game?.endTime == nil
    }
    
    init(context: NSManagedObjectContext? = nil) {
        plebdoku = []
        x = 0
        y = 0
        
        if let context = context {
            // Clear out Games that were started but not finished
            do {
                let gamesFetcheRequest: NSFetchRequest<Game> = Game.fetchRequest()
                gamesFetcheRequest.predicate = NSPredicate(format: "endTime == nil")
                gamesFetcheRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Game.startTime, ascending: false)]
                let unfinishedGames = try context.fetch(gamesFetcheRequest)
                
                game = unfinishedGames.first
                unfinishedGames.dropFirst().forEach(context.delete)
                try context.save()
            } catch {
                NSLog("Error fetching ")
            }
            newGame(context: context)
        } else {
            generatePlebdoku()
        }
        
    }
    
    func generatePlebdoku() {
        let topRows = defaultSudoku[0..<3]
        let middleRows = defaultSudoku[3..<6]
        let bottomRows = defaultSudoku[6..<9]
        
        var shuffledRows = topRows.shuffled()
        shuffledRows.append(contentsOf: middleRows.shuffled())
        shuffledRows.append(contentsOf: bottomRows.shuffled())
        
        //TODO: Shuffle columns
        
        self.plebdoku = shuffledRows
        
        // Pick a random number to be missing
        x = Int.random(in: 0..<9)
        y = Int.random(in: 0..<9)
    }
    
    func newGame(context: NSManagedObjectContext) {
        generatePlebdoku()
        
        if let game = game,
           game.endTime == nil {
            game.startTime = Date()
            game.number = missing
        } else {
            let game = Game(context: context)
            game.startTime = Date()
            game.number = missing
            self.game = game
        }
    }
    
    func plebdokuString() -> String {
        var string = String()
        for row in plebdoku {
            for num in row {
                string.append("\(num)")
            }
            string.append("\n")
        }
        return string
    }
    
    func guess(_ num: Int) {
        game?.winner = num == missing
        game?.endTime = Date()
        PersistenceController.shared.save()
    }
    
    func scoreString(gameController: GameController) -> String {
        guard let game = game else { return "" }
        return "\(gameController.score(game)) points"
    }
    
}
