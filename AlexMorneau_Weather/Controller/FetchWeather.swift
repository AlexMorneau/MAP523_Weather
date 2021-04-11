//
//  FetchWeather.swift
//  AlexMorneau_Weather
//
//  Created by Alex Morneau on 4/6/21.
//

import Foundation

class FetchWeather : ObservableObject {
    var apiURL = "https://api.weatherapi.com/v1/current.json?key=ccdb709d61ca4ac8a6d204615210704&q="
    
    @Published var weatherItem = Weather()
    
    private static var shared : FetchWeather?
    
    static func getInstance() -> FetchWeather {
        if shared != nil {
            return shared!
        }
        else {
            return FetchWeather()
        }
    }
    
    
    func fetchDataFromAPI(city: String) {
        let concatenatedAPI = apiURL + city + "&aqi=no"
        
        guard let api = URL(string: concatenatedAPI) else {
            return
        }
        
        print(#function, "P1 - URL:", concatenatedAPI) // delete
        
        URLSession.shared.dataTask(with: api) { (data: Data?, response: URLResponse?, error: Error?) in
            if let err = error {
                print(#function, "Data could not be fetched: ", err)
            }
            else {
                
                
                print(#function, "P2 - dataTask passed.") // delete
                
                DispatchQueue.global().async {
                    do {
                        if let jsonData = data {
                            let decoder = JSONDecoder()
                            let decodedObj = try decoder.decode(Weather.self, from: jsonData)
                            
                            print(#function, "P3 - DispatchQueue decoder passed.") // delete
                            
                            DispatchQueue.main.async {
                                self.weatherItem = decodedObj
                                
                                print(#function, "P4 - weatherItem Object: ", self.weatherItem) // delete
                            }
                        }
                        else {
                            print(#function, "JSON data was not recieved")
                        }
                    }
                    catch let error {
                        print(#function, "DispatchQueue error: ", error)
                    }
                }
            }
        }.resume()
    }
}
