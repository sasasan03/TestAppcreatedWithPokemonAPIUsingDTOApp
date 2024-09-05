//
//  NarutoAPITest.swift
//  TestAppcreatedWithPokemonAPIUsingDTOTests
//
//  Created by sako0602 on 2024/06/07.
//

import Foundation

final class safafdaadfaTests: XCTestCase {
    
    func testAPIClient_WhenValidResponseProvided_ShouldReturnTrue() {
        // Arrange
        let jsonData = """
        {
            "characters": [
                {
                    "name": "🥺"
                }
            ],
            "currentPage": 1,
            "pageSize": 10,
            "totalCharacters": 100
        }
        """.data(using: .utf8)!
        
        MockFooAPIClient.stubResponseData = jsonData
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockFooAPIClient.self]
        let session = URLSession(configuration: config)
        let sut = FooAPIClient(urlSession: session)
//        let sut = FooAPIClient(urlSession: .shared)
        let expectation = self.expectation(description: "does not return successful response")
        
         
        // Act
        Task {
            do {
                let result = try await sut.fetch()
                // Assert
                XCTAssertEqual(10, 10)
                expectation.fulfill()
            } catch {
                XCTFail("Error: \(error)")
            }
        }
        
        self.wait(for: [expectation], timeout: 3)
//        let config = URLSessionConfiguration.default
//        config.protocolClasses = [StubURLProtocol.self]
//        let session = URLSession(configuration: config)
    }

}


//class GitHubAPITests: XCTestCase {
//
//    func test_テストが成功して値返す() async throws {
//        //スタブ
//        let gitHubRepositories = [
//        GitHubRepository(id: 0, stargazersCount: 9, name: "name1"),
//        GitHubRepository(id: 1, stargazersCount: 10, name: "name2"),
//        GitHubRepository(id: 2, stargazersCount: 11, name: "name3")
//        ]
//        //スタブを注入
//        let mockClient = MockGitHubClient(repositories: gitHubRepositories)
//
//        let manager = GitHubRepositoryManager(client: mockClient)
//
//        let repositories = try await manager.load(user: "apple")!//🍟強制アンラップ
//
//        //引数の検証
////        XCTAssertEqual(mockClient.argsUser, "apple")
//
//        //値の検証
//        XCTAssertEqual(repositories[0], gitHubRepositories[0])// いらない
//        XCTAssertEqual(repositories[1].stargazersCount, 10)
//        XCTAssertEqual(repositories[2].name, "name3")
//
//    }
//
//    func test_ネットワークエラーを返す(){
//    }
//
//}
