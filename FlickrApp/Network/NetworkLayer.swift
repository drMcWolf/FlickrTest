import Foundation

public protocol NetworkLayerProtocol {
    func get(url: String, parameters: [String : Any]?, completion: @escaping (Result<Data, Error>) -> Void)
}

public extension NetworkLayerProtocol {
    func get(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        get(url: url, parameters: nil, completion: completion)
    }
}

final class NetworkLayer {
    private let decoder: JSONDecoder = .init()
    private let session: URLSession = .init(configuration: .default)
    
    private enum NLError {
        static let urlError = ErrorDTO(code: -1, message: "Incorrect format of the url")
        static let unknownError = ErrorDTO(code: -1, message: "Ooops! Something went wrong.")
    }
}

extension NetworkLayer: NetworkLayerProtocol {
    func get(url: String, parameters: [String : Any]?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard
            let percentEncodingURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let endpoint = URL(string: percentEncodingURL)
        else {
            completion(.failure(NetworkLayer.NLError.urlError))
            return
        }
        var request = URLRequest(url: endpoint)
        request.setValue("token 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", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request) { responseData, response, resonseError in
            OperationQueue.main.addOperation {
                switch (responseData, resonseError) {
                case let (.some(data), nil):
                    completion(.success(data))
                case let (nil, .some(error)):
                    completion(.failure(error))
                case let (.some(data), .some(unwrappedError)):
                    do {
                        let errorDTO = try self.decoder.decode(ErrorDTO.self, from: data)
                        completion(.failure(errorDTO))
                    } catch {
                        completion(.failure(unwrappedError))
                    }
                case (nil, nil):
                    completion(.failure(NetworkLayer.NLError.unknownError))
                }
            }
        }
        
        task.resume()
    }
}
