//
//  GitHub.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/05/21.
//

import Foundation

enum GitHubAPIError: Error {
    case networkError(Error) // ネットワーク関連のエラー
    case invalidURL // 無効なURL
    case decodingError(Error) // JSONデコードエラー
    case unauthorized // 認証エラー
    case starCountUnderTen //スターの数が１０個未満
    case notFound // リソースが見つからない
    case rateLimitExceeded // レート制限超過
    case serverError(statusCode: Int) // サーバーエラー（ステータスコード付き）
    case unknown // 不明なエラー
}

//エンティティ
struct GitHubRepository: Decodable, Equatable {
    let id: Int
    let star: Int
    let name: String
}


//データを取得するクラス
class GitHubAPIClient {
    
    func fetchRepository(user: String) async throws -> [GitHubRepository] {
        let url = URL(string: "https://api.github.com/users/\(user)/repos")
        guard let url else { throw GitHubAPIError.invalidURL }
        let request = URLRequest(url: url)
        let (date, _) = try await URLSession.shared.data(for: request)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let gitHubRepositories = try jsonDecoder.decode([GitHubRepository].self, from: date)
        return gitHubRepositories
    }
}


// リポジトリの管理を行う。
class GitHubRepositoryManager {
    
    private let client: GitHubAPIClient
    private var repository: [GitHubRepository]? = nil
    
    //スター数が１０個以上のリポジトリを返す
    var majorRepository: [GitHubRepository] {
        guard let repository else { return []}
        return repository.filter { $0.star >= 10 }
    }
    
    init(){
        self.client = GitHubAPIClient()
    }
    
    func load(user: String) async throws {
        self.repository = try await self.client.fetchRepository(user: user)
    }
    
}
