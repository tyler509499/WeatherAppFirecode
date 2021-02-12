//
//  LocationListVieeController+GMSAutocomplete.swift
//  WeatherAppFirecode
//
//  Created by Galkov Nikita on 12.02.2021.
//

import UIKit
import GooglePlaces

extension LocationListViewController: GMSAutocompleteViewControllerDelegate {

  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

    let newLocation = WeatherLocation(name: place.name ?? "unknown place", latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
    weatherLocations.append(newLocation)
    tableView.reloadData()
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    print("Error: ", error.localizedDescription)
  }
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

}
