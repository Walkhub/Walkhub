import Foundation

public struct Notice: Equatable {
    public let id: Int
    public let title: String
    public let content: String
    public let createdAt: Date
    public let writer: Writer
}
