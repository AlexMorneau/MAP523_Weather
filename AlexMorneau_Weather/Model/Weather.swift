//
//  Weather.swift
//  AlexMorneau_Weather
//
//  Created by Alex Morneau on 4/6/21.
//

import Foundation

struct Weather : Codable {
    
    var current_temp_c : Double
    var current_feelslike_c : Double
    var current_wind_kph : Double
    var current_wind_dir : String
    var current_gust_kph : Double
    var current_humidity : Int
    var current_precip_mm : Double
    
    init() {
        self.current_temp_c = 0.0
        self.current_feelslike_c = 0.0
        self.current_wind_kph = 0.0
        self.current_wind_dir = ""
        self.current_gust_kph = 0.0
        self.current_humidity = 0
        self.current_precip_mm = 0.0
    }
    
    enum CodingKeys : String, CodingKey {
        case current_temp_c = "temp_c"
        case current_feelslike_c = "feelslike_c"
        case current_wind_kph = "wind_kph"
        case current_wind_dir = "wind_dir"
        case current_gust_kph = "gust_kph"
        case current_humidity = "humidity"
        case current_precip_mm = "precip_mm"
        
        case current = "current"
    }
    
    func encode(to encoder: Encoder) throws {
        // empty body
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        
        let current_container = try response.decodeIfPresent(Current.self, forKey: .current)
        
        
        self.current_temp_c = current_container?.temp_c ?? 0.0
        self.current_feelslike_c = current_container?.feelslike_c ?? 0.0
        self.current_wind_kph = current_container?.wind_kph ?? 0.0
        self.current_wind_dir = current_container?.wind_dir ?? "N/A"
        self.current_gust_kph = current_container?.gust_kph ?? 0.0
        self.current_humidity = current_container?.humidity ?? 0
        self.current_precip_mm = current_container?.precip_mm ?? 0.0
    }
    
}


// 'current' object
struct Current : Codable {
    let temp_c : Double?
    let feelslike_c : Double?
    let wind_kph : Double?
    let wind_dir : String
    let gust_kph : Double?
    let humidity : Int?
    let precip_mm : Double?
    
    
    enum CodingKeys : String, CodingKey {
        case temp_c = "temp_c"
        case feelslike_c = "feelslike_c"
        case wind_kph = "wind_kph"
        case wind_dir = "wind_dir"
        case gust_kph = "gust_kph"
        case humidity = "humidity"
        case precip_mm = "precip_mm"
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        
        self.temp_c = try response.decodeIfPresent(Double.self, forKey: .temp_c)
        self.feelslike_c = try response.decodeIfPresent(Double.self, forKey: .feelslike_c)
        self.wind_kph = try response.decodeIfPresent(Double.self, forKey: .wind_kph)
        self.wind_dir = try response.decodeIfPresent(String.self, forKey: .wind_dir) ?? "N/A"
        self.gust_kph = try response.decodeIfPresent(Double.self, forKey: .gust_kph)
        self.humidity = try response.decodeIfPresent(Int.self, forKey: .humidity)
        self.precip_mm = try response.decodeIfPresent(Double.self, forKey: .precip_mm)
    }
    
    func encode(to encoder: Encoder) throws {
        // empty body
    }
}
