
import UIKit
import MapKit
import CoreLocation

class InfoViewController: UIViewController {
    
    let recognize = UILongPressGestureRecognizer()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private let locationManager = CLLocationManager()
    
    let mapTypeControll: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Схема","Гибрид","Спутник"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(changeMapType), for: .valueChanged)
        control.accessibilityIgnoresInvertColors = true
        control.selectedSegmentTintColor = .systemGreen
        control.backgroundColor = .green
        return control
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "mappin.slash.circle"), for: .normal)
        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(removeAnnotations), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(mapView.annotations.count)
        locationManager.delegate = self
        mapView.delegate = self
        setupSubviews()
        locationManager.startUpdatingLocation()
    }
}

extension InfoViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
    }
    
}

extension InfoViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        let alert = UIAlertController(title: "Проложить маршрут", message: nil, preferredStyle: .alert)
        let alertYes = UIAlertAction(title: "Да", style: .default) { _ in
            let directionRequest = MKDirections.Request()
            
            let sourcePlacemark = MKPlacemark(coordinate: self.mapView.userLocation.coordinate)
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            
            let destinationPlacemark = MKPlacemark(coordinate: annotation.coordinate)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .walking
            
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate { [weak self] response, error in
                guard let self = self else { return }
                
                guard let response = response else {
                    if let error = error {
                        print(error)
                    }
                    return
                }
                let route = response.routes[0]
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        let alertNo = UIAlertAction(title: "Нет", style: .default)
        [alertYes,alertNo].forEach(alert.addAction(_:))
        self.present(alert, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.systemGreen
        renderer.lineWidth = 5
        return renderer
    }
}


extension InfoViewController {
    func setupSubviews() {
        [mapView, button, mapTypeControll].forEach(view.addSubview(_:))
        recognize.addTarget(self, action: #selector(self.addPins))
        mapView.addGestureRecognizer(recognize)
        
        let constraints = [
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 10),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),
            
            mapTypeControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mapTypeControll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            mapTypeControll.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            mapTypeControll.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func checkUserLocation() {
        
        
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                locationManager.requestAlwaysAuthorization()
            case .authorizedAlways:
                mapView.showsUserLocation = true
            default:
                break
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
            case .restricted:
                locationManager.requestAlwaysAuthorization()
            case .denied:
                break
            case .authorizedAlways:
                mapView.showsUserLocation = true
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
            @unknown default:
                break
            }
        }
    }
    
    @objc func addPins() {
        let location = recognize.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: nil)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    @objc func removeAnnotations() {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)
    }
    
    @objc func changeMapType() {
        switch mapTypeControll.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default: break
        }
    }
}
