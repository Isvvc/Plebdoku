//
//  NumPad.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import SwiftUI

struct NumPad: View {
    @EnvironmentObject var sudokuController: SudokuController
    
    var body: some View {
        VStack {
            ForEach(0..<3) { col in
                HStack {
                    Spacer()
                    ForEach(0..<3) { row in
                        let num = 7 + row - (col * 3)
                        Button {
                            sudokuController.guess(num)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color(.secondarySystemGroupedBackground))
                                    .shadow(radius: 1, x: 0, y: 1)
                                Text("\(num)")
                            }
                            .aspectRatio(2, contentMode: .fit)
                            .foregroundColor(.primary)
                        }
                    }
                    Spacer()
                }
            }
        }
        .padding(.bottom)
    }
}

struct NumPad_Previews: PreviewProvider {
    static var previews: some View {
        NumPad()
    }
}
