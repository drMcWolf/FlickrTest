import Foundation

struct ErrorDTO: Error, Decodable {
    let code: Int
    let message: String
}
