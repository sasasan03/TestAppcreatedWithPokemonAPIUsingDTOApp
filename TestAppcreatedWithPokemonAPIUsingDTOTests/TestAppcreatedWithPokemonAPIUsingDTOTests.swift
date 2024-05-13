//
//  TestAppcreatedWithPokemonAPIUsingDTOTests.swift
//  TestAppcreatedWithPokemonAPIUsingDTOTests
//
//  Created by sako0602 on 2024/03/29.
//
import Foundation
import XCTest
@testable import TestAppcreatedWithPokemonAPIUsingDTO


class LifecycleTests: XCTestCase{
    override class func setUp() {
        print("#setUp (class)")
    }
    override class func tearDown() {
        print("#tearDown (class)")
    }
    override func setUp() {
        print("#setUp")
    }
    override func tearDown() {
        print("#tearDown")
    }
    func test1(){
        print("#<test1>")
    }
    func test2(){
        print("#<test2>")
    }
}


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

//func assertEmpty(_ string: String){
//    XCTAssertTrue(string.isEmpty,
//    "\"\(string)\"is not empty"
//    )
//}



class CalculatorTests: XCTestCase {
    //　共通で使うクラスを宣言する
    var calc: Calculator!
    
    func test_assertEmpty(){
        let name = ""
        assertEmpty(name)
    }
    
    override func setUp() {
        super.setUp()
        self.calc = Calculator()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAdd(){
        XCTAssertEqual(
            calc.add(10, 20),
            30,
            "値が等しくありません",
            file: #file,
            line: #line
        )
    }
    
    func testSub(){
        XCTAssertEqual(calc.sub(30, 10), 20)
    }
    
    func test_div(){
        XCTAssertEqual(calc.div(6, 3), 2)
        XCTAssertEqual(calc.div(9, 2), 3)
        XCTAssertNil(calc.div(5, 5))
    }
    
    func test_divRunActivity(){
        XCTContext.runActivity(named: "計算成功") { _ in
            XCTAssertEqual(calc.div(6, 3), 2)
            XCTAssertEqual(calc.div(9, 2), 3)
        }
        XCTContext.runActivity(named: "0で割った") { _ in
            XCTAssertNil(calc.div(5, 5))
        }
    }
}



class XCTFunctionActionCheckClass: XCTestCase{
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



class DataSourceTest: XCTestCase{
    var dataSource: DataSourceRepository!
    
    override func setUp() {
        super.setUp()
        self.dataSource = DataSourceRepository()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_fetchData(){
        dataSource.isError = false
        XCTAssertThrowsError(try dataSource.fetchData()){ error in
            XCTAssertEqual(error as? ErrorType, ErrorType.error1)
//            XCTAssertEqual(error as? ErrorType, ErrorType.error2)
        }
    }
    
    func test_fetchData2(){
        let exp: XCTestExpectation = expectation(description: "wait for finish")
        
        dataSource.fetchData(txt: "ko") { txt in
            XCTAssertEqual(txt, "koを取得完了")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }
}
