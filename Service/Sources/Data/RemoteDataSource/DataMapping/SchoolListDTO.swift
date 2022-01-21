import Foundation

struct SchoolListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "school_list"
    }
    let list: [SchoolDTO]
}
