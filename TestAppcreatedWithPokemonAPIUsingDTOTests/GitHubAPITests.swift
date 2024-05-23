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
        let repositories = [
        GitHubRepository(id: 0, stargazersCount: 9, name: ""),
        GitHubRepository(id: 1, stargazersCount: 10, name: ""),
        GitHubRepository(id: 2, stargazersCount: 11, name: "")
        ]
        
        let mockClient = MockGitHubClient(repositories: repositories)
        
        let manager = GitHubRepositoryManager(client: mockClient)
        
        try await manager.load(user: "apple")
        
    }
    
}
