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
        // 取得たポケモンを追加していくためのプロパティ
        var pokemonList: [Pokemon] = []
        
        do {
            //『withThrowingTaskGroup』複数のデータをフェッチしてくるためのメソッド(引数は`@escapingクロージャ`)
            try await withThrowingTaskGroup(of: Pokemon.self) { pokemons in
                for url in urls {
                    guard let url else { throw PokeAPIClientError.invalidURLError }//{ continue } //不正なURLはスキップ
                    pokemons.addTask {
                        let (data, _) = try await URLSession.shared.data(from: url)
                        let dto = try JSONDecoder().decode(ResponseDTO.Pokemon.self, from: data)
                        return Pokemon(dto: dto)
                    }
                }
                for try await pokemon in pokemons {
                    pokemonList.append(pokemon)
                }
            }
        } catch {
            throw PokeAPIClientError.responseParseError
        }
        return pokemonList
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
