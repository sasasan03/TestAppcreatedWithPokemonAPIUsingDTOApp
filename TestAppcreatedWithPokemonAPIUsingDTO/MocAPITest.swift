//
//  MocAPITest.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/04/21.
//

import SwiftUI


enum MocAPIError: Error {
    case invalidResponse
    case fetchError
    case invalidURL
    case unknown
    
    var errorText: String {
        switch self {
        case .invalidResponse:
            "Error: Invalid response or status code not in range 200-299"
        case .fetchError:
            "Error fetching data"
        case .invalidURL:
            "invalid URL"
        case .unknown:
            "unknown"
        }
    }
}

struct MocAPITest: View {
    @State private var items:[Item] = []
    let apiClient = MocAPIClientTest()
    
    var body: some View {
        List(items){ item in
            HStack{
                Image(
                    systemName: item.isChecked
                    ? "checkmark"
                    : "circle.dotted"
                )
                Text("\(item.task)")
            }
        }
        .task {
            do {
                items = try await apiClient.fetch()
            } catch {
                print("###fetch error")
            }
        }
    }
}

struct MocAPIClientTest {
    let urlString = "https://661a369d125e9bb9f29b8b4e.mockapi.io/api/v1/tasks"
    
    func fetch() async throws -> [Item] {
        var items: [Item] = []
        
        return try await withThrowingTaskGroup(of: [Item].self) { group in
            guard let url = URL(string: urlString) else { throw MocAPIError.invalidURL }
            group.addTask {
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else { throw MocAPIError.invalidResponse }
                    return  try JSONDecoder().decode([Item].self, from: data)
                } catch {
                    throw MocAPIError.fetchError
                }
            }
            for try await item in group {
                items = item
            }
            return items
        }
    }
}

struct Item: Identifiable,Decodable {
    let task: String
    let isChecked: Bool
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case task
        case isChecked = "is_checked"
        case id
    }
}

#Preview {
    MocAPITest()
}
