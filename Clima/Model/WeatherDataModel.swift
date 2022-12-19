// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherDataModel = try? newJSONDecoder().decode(WeatherDataModel.self, from: jsonData)

import Foundation

// MARK: - WeatherDataModel
struct WeatherDataModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let pressure, humidity: Int
    let temp_min, temp_max: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case temp_min
        case temp_max
    }
}



// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case description
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

