//
//  PlebdokuTests.swift
//  PlebdokuTests
//
//  Created by Isaac Lyons on 10/12/20.
//

import XCTest
@testable import Plebdoku

class PlebdokuTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSudokuChecker() {
        let sudoku: [[Int8]] = [
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
        checkSudoku(sudoku)
        
        var badRow = sudoku
        badRow[0][8] = 9
        XCTAssertFalse(checkRows(badRow))
        
        var badCol = sudoku
        badCol[8][0] = 9
        XCTAssertFalse(checkColumns(badCol))
        
        var badSquare = sudoku
        badSquare.swapAt(0, 3)
        XCTAssertTrue(checkRows(badSquare))
        XCTAssertTrue(checkColumns(badSquare))
        XCTAssertFalse(checkSquares(badSquare))
    }

    func testPlebdoku() {
        let sudokuController = SudokuController()
        
        // Test the Plebdoku generator 10 times
        for _ in 0..<10 {
            sudokuController.generatePlebdoku()
            checkSudoku(sudokuController.plebdoku)
        }
    }
    
    func checkSudoku(_ sudoku: [[Int8]]) {
        XCTAssertTrue(checkRows(sudoku))
        XCTAssertTrue(checkColumns(sudoku))
        XCTAssertTrue(checkSquares(sudoku))
    }
    
    func checkRows(_ sudoku: [[Int8]]) -> Bool {
        var set: Set<Int8> = []
        
        for row in sudoku {
            for num in row {
                set.insert(num)
            }
            guard set.count == 9 else { return false }
            set.removeAll()
        }
        
        return true
    }
    
    func checkColumns(_ sudoku: [[Int8]]) -> Bool {
        var set: Set<Int8> = []
        
        for col in 0..<9 {
            for row in 0..<9 {
                set.insert(sudoku[row][col])
            }
            guard set.count == 9 else { return false }
            set.removeAll()
        }
        
        return true
    }
    
    func checkSquares(_ sudoku: [[Int8]]) -> Bool {
        var set: Set<Int8> = []
        
        for i in 0..<3 {
            for j in 0..<3 {
                for x in 0..<3 {
                    for y in 0..<3 {
                        set.insert(sudoku[x + (i * 3)][y + (j * 3)])
                    }
                }
                guard set.count == 9 else { return false }
                set.removeAll()
            }
        }
        
        return true
    }

}
