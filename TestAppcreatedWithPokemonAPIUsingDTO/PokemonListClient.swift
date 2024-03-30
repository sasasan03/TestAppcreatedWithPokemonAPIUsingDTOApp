//
//  ListClient.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/03/29.
//

import Foundation

struct PokemonListClient {
    struct ResponseDTO: Decodable {
        struct Pokemon{
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
    
    func fetchData() async throws -> [Pokemon] {
        let urls:[URL?] = getURL()
        let unwrappedURL:[URL] = try urls.map {
            guard let urls = $0 else { throw PokeAPIClientError.invalidURLError }
            return urls
        }
        let request:[URLRequest] = unwrappedURL.map { URLRequest(url: $0)}
        
        
        return [Pokemon]()
    }
    
    private func getURL() -> [URL?] {
        let pokeNumber = 1 ... 150
        var pokeURLs = pokeNumber.map { URL(string: "https://pokeapi.co/api/v2/pokemon/\($0)")}
        return pokeURLs
    }
}
