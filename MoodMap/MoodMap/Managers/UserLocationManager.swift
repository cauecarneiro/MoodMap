//
//  UserLocationManager.swift
//  MoodMap
//
//  Created by Rodrigo Barbosa Pereira on 17/10/25.
//

import CoreLocation
import Combine

class UserLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestUserLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                manager.requestLocation() // Só chama aqui, depois da permissão
            case .denied, .restricted:
                print("Acesso à localização negado.")
            case .notDetermined:
                // Ainda aguardando o usuário responder
                break
            @unknown default:
                break
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        DispatchQueue.main.async { self.userLocation = location.coordinate }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Erro ao obter a localização: \(error.localizedDescription)")
    }
}
