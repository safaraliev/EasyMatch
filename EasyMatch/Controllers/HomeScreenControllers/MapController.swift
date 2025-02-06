import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let locateButton: UIButton = {
    
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 0.87, green: 0.96, blue: 0.35, alpha: 1.0) // Цвет DEF358
        button.tintColor = .black
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.layer.cornerRadius = 30 // Радиус для круглой кнопки
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Настройка карты
        view.addSubview(mapView)
        mapView.frame = view.bounds
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        // Настройка менеджера местоположения
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Запрос разрешения на доступ к местоположению
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Настройка кнопки и добавление её на экран
        setupLocateButton()
    }

    private func setupLocateButton() {
        // Добавляем кнопку на экран
        view.addSubview(locateButton)
        
        // Устанавливаем автолейаут для размещения кнопки в правом нижнем углу
        locateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locateButton.widthAnchor.constraint(equalToConstant: 60),
            locateButton.heightAnchor.constraint(equalToConstant: 60),
            locateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120)
        ])
        
        // Добавляем действие для кнопки
        locateButton.addTarget(self, action: #selector(locateButtonTapped), for: .touchUpInside)
    }

    
    @objc private func locateButtonTapped() {
        // Действие при нажатии на кнопку
        if let userLocation = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
            searchForSoccerFields()
        } else {
            print("Местоположение пользователя недоступно.")
        }
    }
    
    private func searchForSoccerFields() {
            guard let userLocation = locationManager.location?.coordinate else {
                print("Местоположение пользователя недоступно.")
                return
            }
            
            // Настройка запроса поиска
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "Футбольное поле"
            request.region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 5000, longitudinalMeters: 5000) // 5-километровый радиус

            // Выполнение поиска
            let search = MKLocalSearch(request: request)
            search.start { [weak self] (response, error) in
                guard let self = self, let response = response else {
                    print("Не удалось найти результаты: \(error?.localizedDescription ?? "Ошибка")")
                    return
                }
                
                // Удаляем старые аннотации с карты
                self.mapView.removeAnnotations(self.mapView.annotations)
                
                // Добавляем аннотации для каждого найденного футбольного поля
                for mapItem in response.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.title = mapItem.name
                    annotation.coordinate = mapItem.placemark.coordinate
                    self.mapView.addAnnotation(annotation)
                }
                
                // Центрируем карту, чтобы охватить все найденные объекты
                if let firstItem = response.mapItems.first {
                    let region = MKCoordinateRegion(center: firstItem.placemark.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
                    self.mapView.setRegion(region, animated: true)
                }
            }
    }
    

    // MARK: - CLLocationManagerDelegate Methods

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            print("Разрешение на доступ к местоположению не предоставлено.")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Не удалось обновить местоположение: \(error.localizedDescription)")
    }
}
