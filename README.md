# WeatherAppFirecode

В проекте есть три контроллера в папке ViewController -  LocationListViewController, LocationDetailViewController, PageViewController. Модель данных в папке Model, папка c ячейками таблицы и коллекции – Cells, папка с расширениями – Extensions, папка Constants – где лежать API ключи

При запуске приложения открывается LocationDetailViewController. На него автоматически загружаются данные о погоде в вашем городе, при помощи фреймворка Core Location программа получает широту и долготу устройства, отправляет запрос на OpenWeather, с которого мы получаем ответ с погодой текущей, погодой на каждый час и погодой на неделю.

Если на LocationDetailViewController нажать на кнопку справа внизу, то откроется GMSAutocompleteViewController (фреймворк Google Places) в нем в поисковой строке вводим интересующий нас город, нажимаем на него, он заносится в модель данных Model/WeatherLocation.swift.

JSON, который мы получаем по запросу с OpenWeather представлен моделью в файле Model/WeatherDetail.swift, по этой модели происходит парсинг JSON

Модель Model/WeatherLocation.swift хранится в виде JSON в UserDefaults, этот JSON парсится в контроллере PageViewController
Запрос на OpenWeather представлен в Model/WeatherDetail.swift в func getData(completed: @escaping…….

pod init
pod install
