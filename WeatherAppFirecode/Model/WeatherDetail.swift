//
//  WeatherDetail.swift
//  WeatherAppFirecode
//
//  Created by Galkov Nikita on 11.02.2021.
//

import Foundation

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter
}()

private let hourFormatter: DateFormatter = {
    let hourFormatter = DateFormatter()
    hourFormatter.dateFormat = "ha"
    return hourFormatter
}()

struct DailyWeather {
    var dailyIcon: String
    var dailyWeekday: String
    var dailySummary: String
    var dailyHigh: Int
    var dailyLow: Int
}

struct HourlyWeather {
    var hour: String
    var hourlyTemperature: Int
    var hourlyIcon: String
}

class WeatherDetail: WeatherLocation {
    
    
    struct Result: Codable {
        var timezone: String
        var current: Current
        var daily: [Daily]
        var hourly: [Hourly]
    }
    
    struct Current: Codable {
        var dt: TimeInterval
        var temp: Double
        var weather: [Weather]
    }
    
    struct Weather: Codable {
        var description: String
        var icon: String
        var id: Int
    }
    
    struct Daily: Codable {
        var dt: TimeInterval
        var temp: Temp
        var weather: [Weather]
    }
    
    struct Hourly: Codable {
        var dt: TimeInterval
        var temp: Double
        var weather: [Weather]
    }
    
    struct Temp: Codable {
        var max: Double
        var min: Double
    }
    
    var timezone = ""
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var dayIcon = ""
    var dailyWeatherData: [DailyWeather] = []
    var hourlyWeatherData: [HourlyWeather] = []
    
    
    
    func getData(completed: @escaping () -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=metric&appid=\(APIkeys.openWeatherKey)"
        guard let url = URL(string: urlString) else {
            print("ERROR: Can not create URL from \(urlString)")
            completed()
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            do {
                let result = try JSONDecoder().decode(Result.self, from: data!)
                self.timezone = result.timezone
                self.currentTime = result.current.dt
                self.temperature = Int(result.current.temp.rounded())
                self.summary = result.current.weather[0].description
                self.dayIcon = self.systemNameFromID(id: result.current.weather[0].id, icon: result.current.weather[0].icon)
                
                for index in 0..<result.daily.count {
                    let weekdayDate = Date(timeIntervalSince1970: result.daily[index].dt)
                    dateFormatter.timeZone = TimeZone(identifier: result.timezone)
                    let dailyWeekday = dateFormatter.string(from: weekdayDate)
                    let dailyIcon = self.systemNameFromID(id: result.daily[index].weather[0].id, icon: result.daily[index].weather[0].icon)
                    let dailySummary = result.daily[index].weather[0].description
                    let dailyHigh = Int(result.daily[index].temp.max.rounded())
                    let dailyLow = Int(result.daily[index].temp.min.rounded())
                    let dailyWeather = DailyWeather(dailyIcon: dailyIcon, dailyWeekday: dailyWeekday, dailySummary: dailySummary, dailyHigh: dailyHigh, dailyLow: dailyLow)
                    self.dailyWeatherData.append(dailyWeather)
                }
                let lastHour = min(24, result.hourly.count)
                if lastHour > 0 {
                    for index in 1...lastHour {
                    let hourlyDate = Date(timeIntervalSince1970: result.hourly[index].dt)
                    hourFormatter.timeZone = TimeZone(identifier: result.timezone)
                    let hour = hourFormatter.string(from: hourlyDate)
                    let hourlyIcon = self.systemNameFromID(id: result.hourly[index].weather[0].id, icon: result.hourly[index].weather[0].icon)
                    let hourlyTemperature = Int(result.hourly[index].temp.rounded())
                    let hourlyWeather = HourlyWeather(hour: hour, hourlyTemperature: hourlyTemperature, hourlyIcon: hourlyIcon)
                    self.hourlyWeatherData.append(hourlyWeather)
                   }
                }
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        
        task.resume()
    }
    
    private func systemNameFromID(id: Int, icon: String) -> String {
        switch id {
        case 200...299:
            return "cloud.bolt.rain"
        case 300...399:
            return "clous.drizzle"
        case 500, 501, 520, 521, 531:
            return "cloud.rain"
        case 502, 503, 504, 522:
            return "cloud.heavyrain"
        case 511, 611...616:
            return "sleet"
        case 600...602, 620...622:
            return "snow"
        case 701, 711, 741:
            return "cloud.fog"
        case 721:
            return (icon.hasSuffix("d") ? "sun.haze" : "cloud.fog")
        case 731, 751, 761, 762:
            return (icon.hasSuffix("d") ? "sun.dust" : "cloud.fog")
        case 771:
            return "wind"
        case 781:
            return "tornado"
        case 800:
            return (icon.hasSuffix("d") ? "sun.max" : "moon")
        case 801, 802:
            return (icon.hasSuffix("d") ? "cloud.sun" : "cloud.moon")
        case 803, 804:
            return "cloud"
        
        default:
            return "questionmark.diamond"
        }
    }
    
}
