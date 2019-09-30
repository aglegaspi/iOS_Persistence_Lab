
import Foundation

struct PhotoWrapper: Codable {
    let hits: [Photo]
}

struct Photo: Codable {
    let largeImageURL: String
    let likes: Int
    let id: Int
    let views: Int
    let pageURL: String
    let webformatURL: String
    let tags: String
    let favorites: Int
    let userImageURL: String
    let previewURL: String
    
    static func getPhotos(from jsonData: Data) throws -> [Photo] {
        let response = try JSONDecoder().decode(PhotoWrapper.self, from: jsonData)
        return response.hits
    }
}
