import Foundation

enum NetworkLayerError: Error {
    case urlError
}

protocol NetworkLayerProtocol {
    func get(url: String, parameters: [String : Any]?, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkLayer {
    private let session: URLSession = URLSession(configuration: .default)
}

extension NetworkLayer: NetworkLayerProtocol {
    func get(url: String, parameters: [String : Any]?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let percentEncodingURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let endpoint = URL(string: percentEncodingURL) else {
            completion(.failure(NetworkLayerError.urlError))
            return
        }
        let task = session.dataTask(with: endpoint) { data, response, error in
            OperationQueue.main.addOperation {
                if let data = data {
                    completion(.success(data))
                    return
                }
                
                if let error = error {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
