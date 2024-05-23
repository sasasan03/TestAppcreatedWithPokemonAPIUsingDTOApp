//
//  GitHubAPITests.swift
//  TestAppcreatedWithPokemonAPIUsingDTOTests
//
//  Created by sako0602 on 2024/05/23.
//

import Foundation
import XCTest
@testable import TestAppcreatedWithPokemonAPIUsingDTO

class GitHubAPITests: XCTestCase {
    
    func test_load() async throws {
        //スタブ
        let gitHubRepositories = [
        GitHubRepository(id: 0, stargazersCount: 9, name: "name1"),
        GitHubRepository(id: 1, stargazersCount: 10, name: "name2"),
        GitHubRepository(id: 2, stargazersCount: 11, name: "name3")
        ]
        //スタブを注入
        let mockClient = MockGitHubClient(repositories: gitHubRepositories)
        
        let manager = GitHubRepositoryManager(client: mockClient)
        
        let repositories = try await manager.load(user: "apple")!//🍟強制アンラップ
        
        //引数の検証
        XCTAssertEqual(mockClient.argsUser, "apple")
        
        //値の検証
        XCTAssertEqual(repositories[0].id, 0)
        XCTAssertEqual(repositories[1].stargazersCount, 10)
        XCTAssertEqual(repositories[2].name, "name3")
        
    }
    
}
