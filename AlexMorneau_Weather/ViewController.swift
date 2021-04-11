//
//  ViewController.swift
//  AlexMorneau_Weather
//
//  Created by Alex Morneau on 4/6/21.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let weatherFetcher = FetchWeather.getInstance()
    private var weatherObj = Weather()
    
    @IBOutlet var city : UIPickerView!
    
    // labels that will display weather stats
    @IBOutlet var display_temp_c : UILabel!
    @IBOutlet var display_feelslike_c : UILabel!
    @IBOutlet var display_wind_kph : UILabel!
    @IBOutlet var display_wind_dir : UILabel!
    @IBOutlet var display_gust_kph : UILabel!
    @IBOutlet var display_humidity : UILabel!
    @IBOutlet var display_precip_mm : UILabel!
    
    let cityList = [
        "Toronto",
        "Delhi",
        "Tokyo",
        "New_York",
        "Mexico_City",
        "Moscow",
        "London",
        "Paris",
        "Hong_Kong",
        "Lagos"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.city.dataSource = self
        self.city.delegate = self
        
        
        // self.weatherFetcher.fetchDataFromAPI(city: "Toronto")

        
    }
    
    
    @IBAction func updateBtn(_ sender: Any) {
        print(#function, "P6 - updateBtn, object: ", weatherFetcher.weatherItem.current_wind_dir)
        display_temp_c.text = String(weatherFetcher.weatherItem.current_temp_c) + "ºC"
        display_feelslike_c.text = String(weatherFetcher.weatherItem.current_feelslike_c) + "ºC"
        display_wind_kph.text = String(weatherFetcher.weatherItem.current_wind_kph) + " kp/h"
        display_wind_dir.text = weatherFetcher.weatherItem.current_wind_dir
        display_gust_kph.text = String(weatherFetcher.weatherItem.current_gust_kph) + " kp/h"
        display_humidity.text = String(weatherFetcher.weatherItem.current_humidity) + "%"
        display_precip_mm.text = String(weatherFetcher.weatherItem.current_precip_mm) + "mm"
        
    }
    


}


// City picker view functions
//
extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cityList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cityList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print(#function, "City Selected: \(self.cityList[row])")
        //self.weatherFetcher.fetchDataFromAPI(city: self.cityList[row])
        self.weatherFetcher.fetchDataFromAPI(city: self.cityList[row])
        
        
    }
}

