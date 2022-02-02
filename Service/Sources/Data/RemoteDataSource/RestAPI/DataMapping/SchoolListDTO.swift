import Foundation

// MARK: - Data Transfer Object
struct SchoolListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "school_list"
    }
    let list: [SchoolDTO]
}

// MARK: - Mappings to Domain
extension SchoolListDTO {
    func toDomain() -> [School] {
        return list.map { $0.toDomain() }
    }
}
