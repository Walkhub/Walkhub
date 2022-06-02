import Foundation

struct MySchoolRankDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "school_id"
        case name
        case logoImageUrlString = "logo_image_url"
        case grade
        case classNum = "class_num"
    }
    let id: Int
    let name: String
    let logoImageUrlString: String
    let grade: Int?
    let classNum: Int?
}

extension MySchoolRankDTO {
    func toDomain() -> MySchool {
        return .init(
            id: id,
            name: name,
            logoImageUrl: URL(string: logoImageUrlString)!,
            grade: grade ?? 0,
            classNum: classNum ?? 0
        )
    }
}
