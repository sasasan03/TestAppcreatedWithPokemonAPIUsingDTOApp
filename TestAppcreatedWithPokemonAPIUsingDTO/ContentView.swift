//
//  ContentView.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/03/29.
//

import SwiftUI

struct ContentView: View {
    @State private var pokemons:[Pokemon] = []
//    let client = PokemonListClient()
    let client = MocAPIClient()
    
    var body: some View {
        NavigationStack{
            List(pokemons, id: \.name){ pokemon in
                PokemonRowView(
                    name: pokemon.name,
                    url: pokemon.sprite.frontDefault
                )
            }
            .task {
                do {
//                    pokemons = try await client.fetchPokemonDataList()
                    pokemons = try await client.fetch()
                } catch {
                    print(error)
                }
            }
            .navigationTitle("Pokemon 1~151")
        }
    }
}

struct PokemonRowView: View {
    let name: String
    let url: URL
    var body: some View {
        HStack{
            Text(name)
            AsyncImage(url: url)
        }
    }
}

#Preview {
    ContentView()
}
