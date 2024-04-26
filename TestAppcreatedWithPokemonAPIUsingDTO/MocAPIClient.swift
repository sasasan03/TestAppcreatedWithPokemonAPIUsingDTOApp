//
//  MocAPIClient.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/04/21.
//

import Foundation

struct MocAPIClient{
    struct ResponseDTO: Decodable{
        struct Animal: Decodable {
            let id: String
            let name: String
            let image: [FrontImage]
            
            struct FrontImage: Decodable {
                let frontImage: URL
                let id: String
                let newPokemonId: String
                
                enum CodingKeys: String, CodingKey {
                    case frontImage = "front_image"
                    case id
                    case newPokemonId = "new_pokemonId"
                }
            }
        }
    }
    
    func fetch() async throws -> [Pokemon] {
        let urlString = URLLink().urlString
        guard let url = URL(string: urlString) else { return [] }
        let urlRequest = URLRequest(url: url)
        let (data,_) = try await URLSession.shared.data(for: urlRequest)
        let dto = try JSONDecoder().decode([ResponseDTO.Animal].self, from: data)
        return try [Pokemon](dto: dto)
    }
}

private extension Pokemon {
    init(dto: MocAPIClient.ResponseDTO.Animal) throws {
        // 将来的に文字列が入ってくる可能性があるため。パースできなかった時のためにエラーを投げれるようにしておく。
        guard let parseID = { Int(dto.id) }() else {
            throw MockAPIClientError.typeMismatchError
        }
        self = .init(
            id: parseID,
            name: dto.name,
            sprite: Sprite(dto: dto.image[0])
        )
    }
}

private extension Sprite {
    init(dto: MocAPIClient.ResponseDTO.Animal.FrontImage){
        self = .init(frontDefault: dto.frontImage)
    }
}

private extension [Pokemon] {
    init(dto: [MocAPIClient.ResponseDTO.Animal]) throws {
        self = try dto.map { try Pokemon(dto: $0) }
    }
}
