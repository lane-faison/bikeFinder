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
    
    private lazy var map: MKMapView = {
        let m = MKMapView()
        m.delegate = self
        return m
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
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
}

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
