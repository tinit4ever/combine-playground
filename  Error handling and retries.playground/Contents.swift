import UIKit
import Combine

class Post: Decodable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badServerResponse
}

func fetchPosts() -> AnyPublisher<[Post], Error> {
    let url = URL(string: "https://jsonplaceholder.typicode.com/postss")!
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap({ data, response in
            print("Fetch")
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkError.badServerResponse
            }
            return data
        })
        .decode(type: [Post].self, decoder: JSONDecoder())
        .retry(3)
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
