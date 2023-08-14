import Combine
import Foundation

class APIService {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        // Add more methods if needed
    }

    static func requestData<T: Decodable>(
        method: HTTPMethod,
        url: URL,
        parameters: [String: Any] = [:]
    ) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Configure request based on method and parameters
        if method == .post {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
