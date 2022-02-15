import Foundation

public struct MeasuredExercise: Equatable {
    public let exerciseId: Int
    public let imageUrl: URL
    public let startAt: Date
    public let latitude: Double
    public let longitude: Double
}
