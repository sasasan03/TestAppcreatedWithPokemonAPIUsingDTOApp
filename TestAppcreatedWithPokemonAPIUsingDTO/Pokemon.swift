//
//  Pokemon.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/03/29.
//

import Foundation

struct Pokemon {
    let id: Int
    let name: String
    let spritesImage: Sprites
}

struct Sprites {
    let frontDefaulft: URL
}
