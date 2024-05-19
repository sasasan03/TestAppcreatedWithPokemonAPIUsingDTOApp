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
    
    func div(_ a: Int, _ b: Int) -> Int? {
        if b == 0 {
            return nil
        } else {
            return a / b
        }
    }
}

enum ErrorType: Error {
    case error1
    case error2
}

class DataSourceRepository{
    var isError = true
    
    func fetchData() throws {
        if !isError {
            print("データ取得失敗")
            throw ErrorType.error1
        } else {
            print("#データ取得")
        }
    }
    
    func fetchData(txt: String, _ handler: @escaping (String) -> Void){
        print("#1")
        DispatchQueue.global().async {
            print("#3")
            Thread.sleep(forTimeInterval: 2)
            DispatchQueue.main.async {
                handler("\(txt)を取得完了")
                print("#4txt：\(txt)")
            }
            print("#5")
        }
        print("#2")
    }

}

class DateObject {
    
    func isHoliday(_ date: Date = Date()) -> Bool{
        print("#",date.description)
        
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        return weekday == 1 || weekday == 7
    }
    

//    func isHoliday() -> Bool{
//        let now = Date()
//        let calendar = Calendar.current
//        let weekday = calendar.component(.weekday, from: now)
//        return weekday == 1 || weekday == 7
//    }
    
//    func isHoliday(_ now: Date) -> Bool{ //🟨これはおっけ？
//        print("#",now.description)
//        let calendar = Calendar.current
//        let weekday = calendar.component(.weekday, from: now)
//        return weekday == 1 || weekday == 7
//    }

}
