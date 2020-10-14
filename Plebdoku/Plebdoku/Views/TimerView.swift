//
//  TimerView.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var sudokuController: SudokuController
    
    @State private var timerString = "0.00"
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(timerString)
            .font(Font.system(.title, design: .monospaced))
            .onReceive(timer) { _ in
                if sudokuController.timerIsRunning {
                    timerString = String(format: "%.2f", Date().timeIntervalSince(sudokuController.startTime))
                }
            }
            .onChange(of: sudokuController.winner) { winner in
                if let winner = winner {
                    if winner {
                        stopTimer()
                    }
                } else {
                    startTimer()
                }
            }
            .onAppear {
                if sudokuController.winner ?? false {
                    stopTimer()
                } else {
                    startTimer()
                }
            }
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
        sudokuController.timerIsRunning = false
    }
    
    func startTimer() {
        timerString = "0.00"
        timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        sudokuController.timerIsRunning = true
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(SudokuController())
    }
}
