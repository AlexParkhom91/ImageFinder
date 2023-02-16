
import Foundation

// My API key "9d9c4de2d0315e3fea64a5d2714c36b6f61aec693eba4f967f3e45a8a7afaf91"

enum NetworkingError: Error {
    case invalidURL
    case networkError
    case decodingError
}

final class APIManager {
    static let shared = APIManager()

    func fetchPhotos(for query: String, completion: @escaping (Result<[ImagesSeachResult], Error>) -> Void) {
        let APIKey = "9d9c4de2d0315e3fea64a5d2714c36b6f61aec693eba4f967f3e45a8a7afaf91"

        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!

        let urlString = "https://serpapi.com/search.json?&q=\(encodedQuery)&tbm=isch&ijn=0&api_key=\(APIKey)"

        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkingError.networkError))
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(jsonResult.images_results))
            } catch {
                completion(.failure(NetworkingError.decodingError))
            }
        }
        task.resume()
    }
}
