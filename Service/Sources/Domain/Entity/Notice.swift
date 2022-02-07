import Foundation

struct Notice: Equatable {
    let id: Int
    let title: String
    let content: String
    let createdAt: Date
    let writer: Writer
}
