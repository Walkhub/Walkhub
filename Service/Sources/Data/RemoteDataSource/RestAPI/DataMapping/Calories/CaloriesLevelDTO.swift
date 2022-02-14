import Foundation

struct CaloriesLevelDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case levelID = "level_id"
        case foodImageUrlString = "food_image_url"
        case foodName = "food_name"
        case calorie
        case size
        case level
        case message
    }
    let levelID: Int
    let foodImageUrlString: String
    let foodName: String
    let calorie: Int
    let size: String
    let level: Int
    let message: String
}
