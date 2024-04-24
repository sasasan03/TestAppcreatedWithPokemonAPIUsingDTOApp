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
    let sprite: Sprite //画像しか持たせる予定はない。
}

struct Sprite {
    let frontDefault: URL
}
