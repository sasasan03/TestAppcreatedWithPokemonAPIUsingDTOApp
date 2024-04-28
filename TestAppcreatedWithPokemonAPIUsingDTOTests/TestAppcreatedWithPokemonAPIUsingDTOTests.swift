//
//  TestAppcreatedWithPokemonAPIUsingDTOTests.swift
//  TestAppcreatedWithPokemonAPIUsingDTOTests
//
//  Created by sako0602 on 2024/03/29.
//

import XCTest
@testable import TestAppcreatedWithPokemonAPIUsingDTO

//class TestCalculatorTest: XCTestCase {
//    func testAdd() {
//        let calclatore = Calculator()
//        
//        let resulut = calclatore.add(10, 20)
//        
//        XCTAssertEqual(resulut, 30, "答えは30です")
//    }
//    
//    func testSub() {
//        let calclatore = Calculator()
//        
//        let resulut = calclatore.sub(30, 20)
//        
//        XCTAssertEqual(resulut, 10, "答えは30です")
//    }
//}

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








final class TestAppcreatedWithPokemonAPIUsingDTOTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
