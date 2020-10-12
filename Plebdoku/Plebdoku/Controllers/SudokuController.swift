//
//  SudokuController.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import Foundation

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
    
    init() {
        plebdoku = []
        x = 0
        y = 0
        generatePlebdoku()
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
    
}
