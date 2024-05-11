//
//  TestCalculator .swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/04/28.
//

import Foundation

class Calculator {
    func add(_ a: Int,_ b: Int) -> Int{
        a + b
    }
    
    func sub(_ a: Int,_ b: Int) -> Int{
        a - b
    }
    
    var isError = true
    
    func fetchData() throws {
        if !isError {
            print("データ取得失敗")
            throw ErrorType.error1
        } else {
            print("#データ取得")
        }
    }
}

enum ErrorType: Error {
    case error1
    case error2
}
