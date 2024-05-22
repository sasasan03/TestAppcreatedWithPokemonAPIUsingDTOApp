//
//  GitHubView.swift
//  TestAppcreatedWithPokemonAPIUsingDTO
//
//  Created by sako0602 on 2024/05/21.
//

import SwiftUI

struct GitHubView: View {
    
    @State private var repositories: [GitHubRepository] = []
    
    var body: some View {
        NavigationStack{
            Group{
                if !repositories.isEmpty {
                    List(repositories, id: \.id){ repository in
                        VStack{
                            HStack{
                                Text("name:\(repository.name)")
                                Spacer()
                            }
                            HStack{
                                Text("⭐️✖️\(repository.stargazersCount)")
                                Spacer()
                            }
                        }
                    }
                } else {
                    Text("⚠️date nowloading")
                }
            }
            .navigationTitle("GitHub Repository")//NavigationStackにはつけれない。
        }
        .task {
            do {
                let repoManager = GitHubRepositoryManager()
                let _ = try await repoManager.load(user: "apple")
                repositories = repoManager.majorRepository
            } catch let error as GitHubAPIError { //🍟
                print(error)
            } catch {
                print("unknown........")
            }
        }
    }
}

#Preview {
    GitHubView()
}
