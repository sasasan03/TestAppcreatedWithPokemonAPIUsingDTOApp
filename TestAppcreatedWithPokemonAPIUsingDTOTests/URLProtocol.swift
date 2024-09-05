//
//  URLProtocol.swift
//  TestAppcreatedWithPokemonAPIUsingDTOTests
//
//  Created by sako0602 on 2024/06/07.
//

import Foundation

class MockFooAPIClient: URLProtocol{

    static var stubResponseData: Data?
    
    //↓すべてのリクエストを処理することを意味する。falseは？
    override class func canInit(with request: URLRequest) -> Bool { true }
    
    //通常のリクエストを正規のリクエストに変換するように設計されています。ここでは特別なことは何も必要ないため、元のリクエストを返すだけです。
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    //ロードを実行する必要があるときに呼び出され、すぐにテストデータを返します。
    override func startLoading() {
        self.client?.urlProtocol(self, didLoad: Self.stubResponseData ?? Data())
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    //特に何もする必要がないっぽいけど、じゃあなんであるの？
    override func stopLoading() {}
    
}



