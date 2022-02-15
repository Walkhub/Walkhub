import Foundation

struct SearchSchoolListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "school_list"
    }
    let list: [SearchSchoolDTO]
}

extension SearchSchoolListDTO {
    func toDomain() -> [SearchSchool] {
        return list.map { $0.toDomain() }
    }
}
