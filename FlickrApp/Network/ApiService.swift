import CoreLocation
import UIKit

protocol ApiServiceProtocol {
    func getPictures(searchText: String, page: Page, completion: @escaping (Result<FlickrImageSearchDTO, Error>) -> Void)
    func downloadPicture(for id: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

final class FlickrApiService {
    private struct Constants {
        static let apiKey = "9480a18b30ba78893ebd8f25feaabf17"
        static let baseUrl = "https://api.flickr.com/services/rest/"
        static let imageUrl = "http://farm1.static.flickr.com/"
        static let methodSearch = "flickr.photos.search"
        static let methodRecent = "flickr.photos.getRecent"
    }
    private let jsonDecoder: JSONDecoder = .init()
    private let networkLayer: NetworkLayerProtocol
    
    init(with networkLayer: NetworkLayerProtocol) {
        self.networkLayer = networkLayer
    }
}

extension FlickrApiService: ApiServiceProtocol {
    func getPictures(searchText: String, page: Page, completion: @escaping (Result<FlickrImageSearchDTO, Error>) -> Void) {
        let method = searchText.isEmpty ? Constants.methodRecent : Constants.methodSearch
        let url = Constants.baseUrl + "?method=\(method)&api_key=\(Constants.apiKey)&format=json&nojsoncallback=1&text=\(searchText)&page=\(page.pageNumber)&per_page=\(page.itemsCount)"
        
        networkLayer.get(url: url, parameters: nil) { result in
            switch result {
            case let .success(data):
                do {
                    let dto = try self.jsonDecoder.decode(FlickrImagesSearchResponseDTO.self, from: data)
                    completion(.success(dto.photos))
                }catch {
                    completion(.failure(error))
                }
 
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func downloadPicture(for id: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let url = Constants.imageUrl + "\(id).png"
        networkLayer.get(url: url, parameters: nil) { result in
            switch result {
            case let .success(data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
