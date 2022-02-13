import Foundation

public struct UserProfile: Equatable {
    public let userID: Int
    public let name: String
    public let profileImageUrl: URL
    public let school: String
    public let grade: Int?
    public let classNum: Int?
    public let titleBadge: Badge
}
