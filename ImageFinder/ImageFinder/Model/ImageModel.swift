import Foundation

struct APIResponse: Decodable {
    let images_results: [ImagesSeachResult]
}

struct ImagesSeachResult: Decodable, Equatable {
    var position: Int
    let link: String
    let thumbnail: String
    let original: String
}
