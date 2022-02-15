import Foundation

struct SearchSchoolListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "school_list"
    }
    let list: [SearchSchoolListDTO]
}
