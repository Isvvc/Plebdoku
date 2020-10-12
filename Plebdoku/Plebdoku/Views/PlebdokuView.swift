//
//  PlebdokuView.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import SwiftUI

struct PlebdokuView: View {
    
    @EnvironmentObject var sudokuController: SudokuController
    
    var body: some View {
        VStack {
            Button("Plebdoku") {
                print(sudokuController.plebdokuString())
                sudokuController.generatePlebdoku()
                print(sudokuController.plebdokuString())
            }
            VStack {
                ForEach(0..<3) { row in
                    HStack {
                        Spacer()
                        ForEach(0..<3) { col in
                            SudokuSquare(row: row, col: col)
                            if col != 2 {
                                Divider()
                            }
                        }
                        Spacer()
                    }
                    .aspectRatio(11/3, contentMode: .fit)
                    if row != 2 {
                        Divider()
                    }
                }
            }
        }
    }
}

struct SudokuSquare: View {
    @EnvironmentObject var sudokuController: SudokuController
    
    var row: Int
    var col: Int
    
    var body: some View {
        VStack {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { col in
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(.gray)
                            Text("\(sudokuController.plebdoku[row + (self.row * 3)][col + (self.col * 3)])")
                        }
                    }
                }
            }
        }
    }
}

struct PlebdokuView_Previews: PreviewProvider {
    static var previews: some View {
        PlebdokuView()
    }
}
