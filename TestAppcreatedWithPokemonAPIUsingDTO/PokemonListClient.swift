//
//  ListClient.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/03/29.
//

import Foundation

struct PokemonListClient {
    struct ResponseDTO: Decodable {
        struct Pokemon: Decodable{
            let name: String
            let sprites: Sprites
            
            struct Sprites: Decodable {
                let frontDefaulft: URL
                
                // swiftの記述方法に置き換える。
                enum CodingKeys: String, CodingKey {
                    case frontDefaulft = "front_default"
                }
            }
        }
    }
    
    func fetchPokemonDataList() async throws -> [Pokemon] {
        // URL取得
        let urls:[URL?] = getURL()
        
        return try await withThrowingTaskGroup(of: Pokemon.self) { group in
            for url in urls {
                guard let url else { continue } //不正なURLはスキップ
                group.addTask {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let dto = try JSONDecoder().decode(ResponseDTO.Pokemon.self, from: data)
                    return Pokemon(dto: dto)
                }
            }
            // 取得してきたポケモンの配列
            var pokemonList: [Pokemon] = []
            for try await pokemon in group {
                pokemonList.append(pokemon)
            }
            return pokemonList
        }
    }
    
    private func getURL() -> [URL?] {
        let pokeNumber = 1 ... 150
        let pokeURLs = pokeNumber.map { URL(string: "https://pokeapi.co/api/v2/pokemon/\($0)")}
        return pokeURLs
    }
}

private extension Pokemon {
    init(dto: PokemonListClient.ResponseDTO.Pokemon) {
        self = .init(
            name: dto.name,
            spritesImage: Sprites(dto: dto.sprites)
        )
    }
}

private extension Sprites {
    init(dto: PokemonListClient.ResponseDTO.Pokemon.Sprites){
        self = .init(frontDefaulft: dto.frontDefaulft)
    }
}
