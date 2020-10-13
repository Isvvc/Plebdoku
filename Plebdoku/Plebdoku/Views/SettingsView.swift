//
//  SettingsView.swift
//  Plebdoku
//
//  Created by Isaac Lyons on 10/12/20.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("numpadLayout") var numpadLayout = false
    
    var body: some View {
        Form {
            HStack {
                Text("Numpad Layout")
                Spacer()
                Picker("Numpad Layout", selection: $numpadLayout) {
                    Text("Phone").tag(false)
                    Text("10-key").tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
