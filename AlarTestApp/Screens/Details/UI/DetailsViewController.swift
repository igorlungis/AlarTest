//
//  DeteilsViewController.swift
//  AlarTestApp
//
//  Created by Igor Lungis on 11/30/20.
//

import UIKit
import GoogleMaps

class DetailsViewController: UITableViewController {
  
  var placeInfo = PageInfo()
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var mapView: GMSMapView! {
    didSet {
      mapView.layer.cornerRadius = 20
    }
  }
  
  private var location = CLLocationCoordinate2D()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(false, animated: false)
    setupViews()
    configureMapView()
  }
  
  private func setupViews() {
    location = CLLocationCoordinate2D(latitude: placeInfo.lat ?? 0, longitude: placeInfo.lon ?? 0)
    idLabel.text = "ID: \(placeInfo.id ?? "-")"
    nameLabel.text = "Name: \(placeInfo.name ?? "-")"
    countryLabel.text = "Country: \(placeInfo.country ?? "-")"
  }
  
  private func configureMapView() {
    let camera = GMSCameraPosition.camera(withTarget: location, zoom: 14)
    mapView.camera = camera
    let marker = GMSMarker()
    marker.position = location
    marker.map = mapView
  }
  
}

