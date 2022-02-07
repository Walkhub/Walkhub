import Foundation

struct UserProfile: Equatable {
    let userID: Int
    let name: String
    let profileImageUrl: URL
    let school: String
    let grade: Int?
    let classNum: Int?
    let titleBadge: Badge
}
