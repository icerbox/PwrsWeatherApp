//
//  LocationService.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 27.02.2026.
//

import CoreLocation

protocol LocationServiceProtocol {

    var locationServiceDelegate: LocationServiceDelegate? { get set }

    /// Получение местоположения пользователя
    func getUserLocation() -> CLLocation?

    /// Получение статуса разрешения местоположения пользователя
    func authorizationStatus() -> CLAuthorizationStatus

    /// Запрос на разрешение использования местоположения
    func requestLocationPermission()

    /// Запуск нахождения местоположения
    func startUpdatingLocation()
}

protocol LocationServiceDelegate: AnyObject {

    func didUpdateLocations(_ locations: [CLLocation])

    func didFailWithError(_ error: Error)

    func locationPermissionDenied()
}

final class LocationService: NSObject, LocationServiceProtocol {

    private let locationManager = CLLocationManager()
    private var isFirstUpdate = true

    weak var locationServiceDelegate: LocationServiceDelegate?

    override init() {
        super.init( )
        configure()
    }

    private func configure() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
    }

    // Получение местоположения пользователя
    func getUserLocation() -> CLLocation? {
        return locationManager.location
    }

    // Запрос на разрешение использования местоположения пользователя
    func authorizationStatus() -> CLAuthorizationStatus {
        locationManager.authorizationStatus
    }

    // Запрос на разрешение использования местоположения
    func requestLocationPermission() {
        let status = locationManager.authorizationStatus

        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            locationServiceDelegate?.locationPermissionDenied()
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
        @unknown default:
            break
        }
    }

    // Запуск нахождения местоположения
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            let status = manager.authorizationStatus

            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                startUpdatingLocation()
            case .denied, .restricted:
                locationServiceDelegate?.locationPermissionDenied()
            case .notDetermined:
                print("Разрешение еще не запрашивалось")
            @unknown default:
                break
            }
        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationServiceDelegate?.didUpdateLocations(locations)
        print("Получены координаты:", locations)

        if isFirstUpdate {
            isFirstUpdate = false
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
        locationServiceDelegate?.didFailWithError(error)
    }
}
