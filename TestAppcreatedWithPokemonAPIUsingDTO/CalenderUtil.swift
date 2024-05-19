//
//  CalenderUtil.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/05/18.
//

import Foundation


protocol DateProtocol {
    func now() -> Date
}

//本番環境で使用
class DateDefaults: DateProtocol{
    func now()-> Date {
        return Date()
    }
}

//休日かどうかを判断するメソッドを持つクラス
class CalenderUtil {
    let dateProtocol: DateProtocol
    
    init(dateProtocol: DateProtocol = DateDefaults()) {
        self.dateProtocol = dateProtocol
    }
    
    func isHoliday() -> Bool{
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: dateProtocol.now())
        return weekday == 1 || weekday == 7
    }
}

//モック
struct MockDateProvider: DateProtocol {
    var date: Date! = nil
    
    func now() -> Date {
        return date!
    }
}
