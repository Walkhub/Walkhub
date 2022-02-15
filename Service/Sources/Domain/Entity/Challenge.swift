import Foundation

public struct Challenge: Equatable {
    public let id: Int
    public let name: String
    public let start: Date
    public let end: Date
    public let imageUrl: URL
    public let userScope: String
    public let goalScope: String
    public let goalType: String
    public let writer: Writer
}
