//
//  Error.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/03/30.
//

import Foundation

enum PokeAPIClientError: Error {
    case invalidURLError
    // 通信に失敗した場合に使用する
    case connectionError
    // データを受け取ったがパースに失敗した場合に投げられるエラー
    case responseParseError
    //　未知のエラーが発生
    case unknown
}
