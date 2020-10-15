//
//  NumPad.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import SwiftUI

struct NumPad: View {
    @EnvironmentObject var sudokuController: SudokuController
    @AppStorage("numpadLayout") var numpadLayout = false
    
    @GestureState private var guess = 0
    
    var body: some View {
        VStack {
            ForEach(0..<3) { col in
                HStack {
                    Spacer()
                    ForEach(0..<3) { row in
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(.secondarySystemGroupedBackground))
                                .shadow(radius: 1, x: 0, y: 1)
                            Text("\(num(row: row, col: col))")
                        }
                        .aspectRatio(2, contentMode: .fit)
                        .foregroundColor(sudokuController.gameInProgress ? .primary : .secondary)
                        .gesture(DragGesture(minimumDistance: 0)
                                    .updating($guess) { _, guess, _ in
                                        let num = self.num(row: row, col: col)
                                        if guess != num,
                                           sudokuController.gameInProgress {
                                            sudokuController.guess(num)
                                            guess = num
                                        }
                                    })
                    }
                    Spacer()
                }
            }
        }
        .padding(.bottom)
    }
    
    private func num(row: Int, col: Int) -> Int {
        numpadLayout ? 7 + row - col*3 : row + col*3 + 1
    }
}

struct NumPad_Previews: PreviewProvider {
    static var previews: some View {
        NumPad()
            .environmentObject(SudokuController())
    }
}
