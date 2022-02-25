import Foundation

public struct RankedUser: Equatable {
    public let userId: Int
    public let name: String
    public let ranking: Int
    public let profileImageUrl: URL
    public let walkCount: Int
}
