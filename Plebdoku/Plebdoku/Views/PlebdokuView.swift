//
//  PlebdokuView.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import SwiftUI

struct PlebdokuView: View {
    
    @EnvironmentObject var sudokuController: SudokuController
    
    var gridSpacing: CGFloat = 4.0
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Button("Plebdoku") {
                    print(sudokuController.plebdokuString())
                    sudokuController.generatePlebdoku()
                    print(sudokuController.plebdokuString())
                }
                VStack(spacing: gridSpacing) {
                    ForEach(0..<3) { row in
                        HStack(spacing: gridSpacing) {
                            Spacer()
                            ForEach(0..<3) { col in
                                SudokuSquare(row: row, col: col, gridSpacing: gridSpacing)
                                if col != 2 {
                                    Divider()
                                }
                            }
                            Spacer()
                        }
                        .aspectRatio(10/3, contentMode: .fit)
                        if row != 2 {
                            Divider()
                        }
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
    var gridSpacing: CGFloat
    
    var body: some View {
        VStack(spacing: gridSpacing) {
            ForEach(0..<3) { row in
                HStack(spacing: gridSpacing) {
                    ForEach(0..<3) { col in
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(Color(.secondarySystemGroupedBackground))
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
