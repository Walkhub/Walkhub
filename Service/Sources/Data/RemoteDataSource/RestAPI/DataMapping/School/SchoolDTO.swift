import Foundation

// MARK: - Data Transfer Object
struct SchoolDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case schoolId = "school_id"
        case name
        case ranking
        case studentsCount = "student_count"
        case logoImageUrlString = "logo_image_url"
        case walkCount = "walk_count"
    }
    let schoolId: Int
    let name: String
    let ranking: Int
    let studentsCount: Int
    let logoImageUrlString: String
    let walkCount: Int
}

// MARK: - Mappings to Domain
extension SchoolDTO {
    func toDomain() -> School {
        return .init(
            schoolId: schoolId,
            name: name,
            ranking: ranking,
            studentsCount: studentsCount,
            logoImageUrl: URL(string: logoImageUrlString)!,
            walkCount: walkCount
        )
    }
}
