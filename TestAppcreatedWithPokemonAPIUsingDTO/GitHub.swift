//
//  GitHub.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/05/21.
//

import Foundation

enum GitHubAPIError: Error {
    case networkError // ネットワーク関連のエラー
    case invalidURL // 無効なURL
    case decodingError(Error) // JSONデコードエラー
    case notFound // リソースが見つからない
    case serverError(statusCode: Int) // サーバーエラー（ステータスコード付き）
    case repositoryEmpty // リポジトリーが空
    case unknown // 不明なエラー
}

//エンティティ
struct GitHubRepository: Decodable, Equatable, Comparable {
    static func < (lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
        return lhs.stargazersCount < rhs.stargazersCount
    }
    
    let id: Int
    let stargazersCount: Int
    let name: String
}

//データを取得するクラス
class GitHubAPIClient: GitHubAPIProtocol {
    
    func fetchRepository(user: String) async throws -> [GitHubRepository] {
        let url = URL(string: "https://api.github.com/users/\(user)/repos")
        guard let url else { throw GitHubAPIError.invalidURL }
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let gitHubRepositories = try jsonDecoder.decode([GitHubRepository].self, from: data)
        return gitHubRepositories
    }
}


protocol GitHubAPIProtocol {
    func fetchRepository(user: String) async throws -> [GitHubRepository]
}


// リポジトリの管理を行う。
class GitHubRepositoryManager {
    
    let client: GitHubAPIProtocol// 🍔型をプロトコルにする
    private var repository: [GitHubRepository]? = nil
    
    //スター数が１０個以上のリポジトリをフィルターし、スターの多い数からスタックに追加した配列を返す。
    var majorRepository: [GitHubRepository] {
        guard let repository else { return [] }
        return repository.filter({ $0.stargazersCount >= 10 }).sorted(by: <)
    }
    
    init(client: GitHubAPIProtocol = GitHubAPIClient()){
        self.client = client// 🍔プロトコルを使って差し替え可能に変更
    }
    
    func load(user: String) async throws -> [GitHubRepository]? {
        self.repository = try await self.client.fetchRepository(user: user)
        return self.repository
    }
    
}
