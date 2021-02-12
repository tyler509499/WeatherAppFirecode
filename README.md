# WeatherAppFirecode
1)	Галков Никита
2)	Тестовое задание iOS
3)	

А)В проекте есть три контроллера в папке ViewController -  LocationListViewController, LocationDetailViewController, PageViewController. Модель данных в папке Model, папка c ячейками таблицы и коллекции – Cells, папка с расширениями – Extensions, папка Constants – где лежать API ключи

Б)При запуске приложения открывается LocationDetailViewController. На него автоматически загружаются данные о погоде в вашем городе, при помощи фреймворка Core Location программа получает широту и долготу устройства, отправляет запрос на OpenWeather, с которого мы получаем ответ с погодой текущей, погодой на каждый час и погодой на неделю.

В) Если на LocationDetailViewController нажать на кнопку справа внизу, то откроется GMSAutocompleteViewController (фреймворк Google Places) в нем в поисковой строке вводим интересующий нас город, нажимаем на него, он заносится в модель данных Model/WeatherLocation.swift.

Г) JSON, который мы получаем по запросу с OpenWeather представлен моделью в файле Model/WeatherDetail.swift, по этой модели происходит парсинг JSON

Д) Модель Model/WeatherLocation.swift хранится в виде JSON в UserDefaults, этот JSON парсится в контроллере PageViewController
Е) Запрос на OpenWeather представлен в Model/WeatherDetail.swift в func getData(completed: @escaping…….

Cамая большая и неожиданная проблема, с которой столкнулся, это то, что запрос на погоду текущую, часовую и недельную происходит с использованием широты и долготы города, погода в котором нас интересует. Обычный же запрос на текущую погоду требует просто название города и API ключ. В связи с этим было принято использовать фреймворк GooglePlaces. Для сетевого запроса я обычно использую фреймворк Alamofire, но в данном случае решил обойтись стандартными средствами языка swift

4)	Лучше всего клонировать проект с github. Используются следующие библиотеки:
- UIKit
- Core Location
-Google Places (через Cocoa pods)

Открыть папку проекта через терминал. Набрать команду “pod init”
Создатся Pod файл, открыть его и заменить его содержимое на следующее:


platform :ios, '11.0'

target 'WeatherAppFirecode' do

pod 'GooglePlaces'


end

Затем снова открыть терминал с папкой проекта и набрать команду “pod install”
5)	API ключи находятся в папке Constants/APIKeys
6)	запускаем файл с расширением OpenWeatherAppFirecode.workspace
