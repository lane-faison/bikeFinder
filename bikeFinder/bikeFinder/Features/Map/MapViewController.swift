//
//  MapViewController.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/26/21.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    private var viewModel: MapViewModel!
    
    static func instantiate(with viewModel: MapViewModel) -> MapViewController {
        let vc = MapViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    private lazy var zoomInButton = UIBarButtonItem(image: AppImages.zoomIn,
                                       style: .plain,
                                       target: self,
                                       action: #selector(zoomIn))
    
    private lazy var zoomOutButton = UIBarButtonItem(image: AppImages.zoomOut,
                                        style: .plain,
                                        target: self,
                                        action: #selector(zoomOut))
    
    // ~135 is the maximum latitude, ~131 is the maximum longitude
    // Not controlling the maximum latitude/longitude will crash the app after zooming out continually.
    private let maximumAllowableLatitudeDelta: CLLocationDegrees = 135
    private let maximumAllowableLongitudeDelta: CLLocationDegrees = 131
    
    private lazy var map: MKMapView = {
        let m = MKMapView()
        m.delegate = self
        return m
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupAppBarButtons()
        addAndShowLocations()
        
        Toast.showHint(type: .info,
                       messageTitle: "Zoom out to see other location(s)",
                       actionTitle: "DISMISS")
    }
}

// MARK: - UI Helpers

extension MapViewController {
    
    private func setupView() {
        view.addSubview(map)
        map.activateEdgeConstraints()
    }
    
    private func setupAppBarButtons() {
        navigationItem.rightBarButtonItems = [zoomOutButton, zoomInButton]
    }
    
    private func addAndShowLocations() {
        map.addAnnotations(viewModel.networkLocations)
        
        var annotationsToShow: [NetworkLocation] = []
        
        if let highlightedNetwork = viewModel.highlightedNetwork {
            annotationsToShow = [highlightedNetwork]
        } else {
            annotationsToShow = viewModel.networkLocations
        }
        map.showAnnotations(annotationsToShow, animated: true)
    }
    
    @objc private func zoomIn() {
        zoom(delta: 0.3)
    }
    
    @objc private func zoomOut() {
        zoom(delta: 3)
    }
    
    private func zoom(delta: Double) {
        var region: MKCoordinateRegion = self.map.region
        var span: MKCoordinateSpan = map.region.span
        span.latitudeDelta *= delta
        span.longitudeDelta *= delta
        
        span.latitudeDelta = min(maximumAllowableLatitudeDelta, span.latitudeDelta)
        span.longitudeDelta = min(maximumAllowableLongitudeDelta, span.longitudeDelta)
        
        // Disable zoomOut button if maximum latitudeDelta & longitudeDelta reached
        zoomOutButton.isEnabled = (span.latitudeDelta != maximumAllowableLatitudeDelta || span.longitudeDelta != maximumAllowableLongitudeDelta)
        
        region.span = span
        map.setRegion(region, animated: true)
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is NetworkLocation else { return nil }

        let identifier = "NetworkLocation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            annotationView?.tintColor = AppColors.primaryColor
            annotationView?.glyphImage = AppImages.bicycle
            annotationView?.markerTintColor = AppColors.darkPrimaryColor
            
            if annotationView?.annotation?.coordinate == viewModel.highlightedNetwork?.coordinate {
                annotationView?.markerTintColor = AppColors.accentColor
            }
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? NetworkLocation else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info

        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
