//
//  TestAppcreatedWithPokemonAPIUsingDTOTests.swift
//  TestAppcreatedWithPokemonAPIUsingDTOTests
//
//  Created by sako0602 on 2024/03/29.
//
import Foundation
import XCTest
@testable import TestAppcreatedWithPokemonAPIUsingDTO

func assertEmpty(
    _ string: String,
    file: StaticString = #file,
    line: UInt = #line
){
    XCTAssertTrue(string.isEmpty,
    "\"\(string)\"is not empty",
    file: file,
    line: line
    )
}

class TestCalculatorTest: XCTestCase {
    
    func test_assertEmpty(){
        let name = "sako"
        assertEmpty(name)
    }
    
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
        XCTAssertEqual(
            calc.add(10, 30),
            30,
            "値が等しくありません",
            file: #file,
            line: #line
        )
    }
    
    func testSub(){
        XCTAssertEqual(calc.sub(30, 10), 20)
    }
    
    func test_fetchData(){
        calc.isError = false
        XCTAssertThrowsError(try calc.fetchData()){ error in
            XCTAssertEqual(error as? ErrorType, ErrorType.error1)
//            XCTAssertEqual(error as? ErrorType, ErrorType.error2)
        }
    }
    
    let isShowView = false
    let num: Int? = nil
    let txt1 = "sako"
    let txtEmpty = ""
    let txt2 = "sako"
    let error1 = ErrorType.error1
    
    
//    func test_assert() {
//        
//        XCTAssertTrue(txtEmpty.isEmpty)//Trueであることを
//        XCTAssertFalse(isShowView)//falseであるこを期待
//        
//        XCTAssertNil(num)// nil期待
//        XCTAssertNotNil(num)// nilでないことを期待
//        
//        XCTAssertEqual(txt1, txt2) // 引数１と引数２が一致
//        XCTAssertNotEqual(txt1, txt2) // 引数１と引数２が一致
//        
//        XCTAssertGreaterThan(txt1, txt2) // 大小の比較
//        XCTAssertGreaterThanOrEqual(txt1, txt2) //大小の比較
//        XCTAssertLessThan(txt1, txt2) // 大小の比較
//        XCTAssertLessThanOrEqual(txt1, txt2) //大小の比較
//        
//        XCTFail()// 失敗させる
//        
//        XCTAssertThrowsError(error1)// 例外の判定
//    }
    
}


