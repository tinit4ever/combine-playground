import UIKit
import Combine

class Post: Decodable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

func fetchPosts() -> AnyPublisher<[Post], Error> {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: [Post].self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

var cancellabless: Set<AnyCancellable> = []

fetchPosts().sink { comletion in
    switch comletion {
    case .finished:
        print("Update UI")
    case .failure(let error):
        print("Error \(error)")
    }
} receiveValue: { posts in
    let _ = posts.map { post in
        print("Title \(post.title)")
    }
}.store(in: &cancellabless)
