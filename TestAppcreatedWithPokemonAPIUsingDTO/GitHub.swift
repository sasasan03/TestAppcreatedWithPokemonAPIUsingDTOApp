//
//  GitHub.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/05/21.
//

import Foundation

enum HTTPError: Error {
    case badRequest // 400
    case unauthorized // 401
    case forbidden // 403
    case notFound // 404
    case internalServerError // 500
    case serviceUnavailable // 503
    case unknown // その他のエラー
    
    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "不正なリクエスト (400): 無効な構文のため、サーバーはリクエストを理解できませんでした。"
        case .unauthorized:
            return "認証が必要 (401): リクエストされたレスポンスを得るためにはクライアントが認証される必要があります。"
        case .forbidden:
            return "アクセス禁止 (403): クライアントはコンテンツにアクセスする権限がありません。"
        case .notFound:
            return "リソースが見つかりません (404): サーバーはリクエストされたリソースを見つけることができません。"
        case .internalServerError:
            return "サーバー内部エラー (500): サーバーは対応方法がわからない状況に直面しました。"
        case .serviceUnavailable:
            return "サービス利用不可 (503): サーバーは現在リクエストを処理できません。"
        case .unknown:
            return "不明なエラーが発生しました。"
        }
    }
}

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
struct GitHubRepository: Decodable, Comparable {
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

class MockGitHubClient: GitHubAPIProtocol {
    
    var returnHTTPError: HTTPError?
    
    var returnGitHubAPIError:
    
    var returnRepositories: [GitHubRepository] //①リポジトリを保持させるプロパティ
    var argsUser: String? //②引数を記録するプロパティ❓何に使うのか？
    
    init(repositories: [GitHubRepository]) {
        self.returnRepositories = repositories
    }
    
    func fetchRepository(user: String) async throws -> [GitHubRepository] {
        self.argsUser = user
        return returnRepositories
    }
    
}


protocol GitHubAPIProtocol {
    func fetchRepository(user: String) async throws -> [GitHubRepository]
}


// リポジトリの管理を行う。Viewでインスタンス化させ、実行するクラス
class GitHubRepositoryManager {
    
    private let client: GitHubAPIProtocol// 🍔型をプロトコルにする
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
