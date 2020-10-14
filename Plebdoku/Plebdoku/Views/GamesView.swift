//
//  GamesView.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/13/20.
//

import SwiftUI

struct GamesView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Game.startTime, ascending: false)])
    private var games: FetchedResults<Game>
    
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
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
