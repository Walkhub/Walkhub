import Foundation

class AccountInfoDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "account_id"
        case phoneNumber = "phone_number"
    }
    let id: String
    let phoneNumber: String
}

extension AccountInfoDTO {
    func toDomain() -> AccountInfo {
        return .init(
            id: self.id,
            phoneNumber: self.phoneNumber
        )
    }
}
