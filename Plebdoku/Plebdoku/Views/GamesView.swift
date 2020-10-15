//
//  GamesView.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/13/20.
//

import SwiftUI

struct GamesView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Game.startTime, ascending: false)],
        predicate: NSPredicate(format: "endTime != nil"))
    private var games: FetchedResults<Game>
    
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        HStack {
            Text("Total Score:")
            let score = games.map { gameController.score($0) }.reduce(0, +)
            Text("\(score)")
                .foregroundColor(score > 0 ? .green : .red)
        }
        .font(.title)
        List {
            ForEach(games) { game in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(game.number): \(gameController.time(game) ?? "Unfinished")")
                        Text(gameController.startDate(game))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text("\(gameController.score(game)) points")
                        .foregroundColor(game.winner ? .green : .red)
                }
            }
        }
        .navigationTitle("History")
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GamesView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .environmentObject(GameController())
        }
    }
}
