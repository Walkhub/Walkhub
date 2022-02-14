import Foundation

public struct User: Equatable {
    public let userID: Int
    public let name: String
    public let ranking: Int
    public let grade: Int
    public let classNum: Int
    public let profileImageUrl: URL
    public let walkCount: Int
}
