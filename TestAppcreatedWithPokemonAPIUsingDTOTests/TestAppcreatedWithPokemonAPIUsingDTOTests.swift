//
//  TestAppcreatedWithPokemonAPIUsingDTOTests.swift
//  TestAppcreatedWithPokemonAPIUsingDTOTests
//
//  Created by sako0602 on 2024/03/29.
//

import XCTest
@testable import TestAppcreatedWithPokemonAPIUsingDTO

class TestCalculatorTest: XCTestCase {
    //　共通で使うクラスを宣言する
    var calc: Calculator!
    
    // 上記で言う、let calclatore = Calculator()をここで行なっている。
    override func setUp() {
        super.setUp()
        self.calc = Calculator()
    }
    
    // 全てのテストのあと処理を書くことができる。
    override func tearDown() {
        super.tearDown()
    }
    
    func testAdd(){
        XCTAssertEqual(calc.add(10, 20), 30)
    }
    
    func testSub(){
        XCTAssertEqual(calc.sub(30, 10), 20)
    }
}


