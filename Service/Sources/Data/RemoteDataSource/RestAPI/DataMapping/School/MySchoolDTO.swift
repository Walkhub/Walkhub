import Foundation

struct MySchoolDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "school_id"
        case name
        case logoImageUrlString = "logo_image_url"
        case walkCount = "walk_count"
        case grade
        case classNum = "class_num"
    }
    let id: Int
    let name: String
    let logoImageUrlString: String
    let walkCount: Int
    let grade: Int
    let classNum: Int
}

extension MySchoolDTO {
    func toDomain() -> MySchool {
        return .init(
            id: id,
            name: name,
            logoImageUrlString: URL(string: logoImageUrlString)!,
            walkCount: walkCount,
            grade: grade,
            classNum: classNum
        )
    }
}
