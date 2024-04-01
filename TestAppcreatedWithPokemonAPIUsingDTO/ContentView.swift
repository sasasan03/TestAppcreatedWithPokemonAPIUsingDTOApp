//
//  ContentView.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/03/29.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        List(){
            
        }
    }
}

struct PokemonRowView: View {
    var body: some View {
        HStack {
            Text("")
            AsyncImage(url: URL(string: "https://www.yahoo.com/")!)
        }
    }
}

#Preview {
    ContentView()
}
