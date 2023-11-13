import UIKit
import Combine

class WeatherClient {
    var update = PassthroughSubject<Int, Never>()
    
    func fetchWeather() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.update.send(Int.random(in: 1...30))
        }
    }
}

let client = WeatherClient()

let cancellable = client.update.sink { value in
    print(value)
}

client.fetchWeather()
