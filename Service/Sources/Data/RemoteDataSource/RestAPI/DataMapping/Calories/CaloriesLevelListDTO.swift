import Foundation

struct CaloriesLevelListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case caloriesLevelList = "calories_level_list"
    }
    let caloriesLevelList: [CaloriesLevelDTO]
}
