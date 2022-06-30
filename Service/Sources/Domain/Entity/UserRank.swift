import Foundation

public struct UserRank: Equatable {
    public let isJoinedClass: Bool
    public let myRank: RankedUser
    public let rankList: [RankedUser]
}
