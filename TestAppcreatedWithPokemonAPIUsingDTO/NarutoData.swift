//
//  NarutoData.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/06/07.
//

import Foundation

//APIClientのファイル内でfileprivate privateにする
struct NarutoDTO: Decodable {
    let characters:[CharacterDTO]
    let currentPage: Int
    let pageSize: Int
    let totalCharacters: Int

    struct CharacterDTO: Decodable {
        let name: String
    }
}

struct NarutoData: Decodable {
    let characters: [Character]
    let pagination: Pagination

    struct Pagination: Decodable {
        let currentPage: Int
        let pageSize: Int
        let totalCharacters: Int
    }

    struct Character: Decodable, Hashable {
        let name: String
    }
}

extension NarutoData {
    init(dto: NarutoDTO) {
        self.characters = dto.characters.map {NarutoData.Character(dto: $0)}
        self.pagination = Pagination(dto: dto)
    }
}

extension NarutoData.Pagination {
    init(dto: NarutoDTO) {
        self.currentPage = dto.currentPage
        self.pageSize = dto.pageSize
        self.totalCharacters = dto.totalCharacters
    }
}

private extension NarutoData.Character {
    init(dto: NarutoDTO.CharacterDTO) {
        self.name = dto.name

    }
}

public struct FooAPIClient {

    let urlSession: URLSession
    
    public init(
        urlSession: URLSession = .shared
    ){
        self.urlSession = urlSession
    }
    
    func fetch() async throws -> [NarutoData] {
        guard let url = URL(string: "https://narutodb.xyz/api/character") else {
            return []
        }
        //🟥urlSessionの下で停止している
        let (data,_) = try await urlSession.data(from: url)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode([NarutoData].self, from: data)
//        return NarutoData(dto: decodedData).characters
    }
}

