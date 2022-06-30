import Foundation

struct SchoolDetailsDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case week
        case month
    }
    let week: SchoolDetailInformationDTO
    let month: SchoolDetailInformationDTO
}

extension SchoolDetailsDTO {
    func toDomain() -> SchoolDetails {
        return .init(
            week: week.toDomain(),
            month: month.toDomain()
        )
    }
}
