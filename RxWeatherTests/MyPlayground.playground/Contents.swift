import UIKit

let city = City(name: "Seoul")
Service.shared.get(city: city).subscribe{ print($0) }

/**
 d9903c30248147512578f00b79c7ccab
 
 
 api.openweathermap.org/data/2.5/weather?q={city name}&units=metric&lang=kr&appid={API key}
 
 (q) {city name} : 도시 이름이 영문으로 들어간다.
 units : 온도의 단위를 설정한다. metric은 섭씨, imperial은 화씨, 비어있으면 켈빈 단위로 설정된다.
 lang : 언어가 들어간다.
 (appid) {API Key} : 아까 위에서 복사한 자신의 API 키가 들어간다.
 
 
 
 {
 "coord": {
 "lon": 96.3902,
 "lat": 25.5123
 },
 "weather": [
 {
 "id": 254,
 "main": "Cloudy",
 "description": "흐림",
 "icon": "50n"
 }
 ],
 "base": "stations",
 "main": {
 "temp": 199.36,
 "feels_like": 152.33,
 "temp_min": 148.71,
 "temp_max": 178.25,
 "pressure": 136,
 "humidity": 51
 },
 "visibility": 1200,
 "wind": {
 "speed": 2.57,
 "deg": 280
 },
 "clouds": {
 "all": 75
 },
 "dt": 1623419189,
 "sys": {
 "type": 1,
 "id": 8105,
 "country": "KR",
 "sunrise": 1623355826,
 "sunset": 1623408789
 },
 "timezone": 32400,
 "id": 1835848,
 "name": "Seoul",
 "cod": 200
 }
 */
