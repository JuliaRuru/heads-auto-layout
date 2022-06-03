//
//  LocationViewController.swift
//  hnh1
//
//  Created by Юлия Руднева on 30.05.2022.
//

import UIKit
import JGProgressHUD
import SwiftUI

class LocationViewController: UIViewController {
    
    let networkManager = ServiceLocator.locationNetworkManager()
    let progressHUD = JGProgressHUD()
    var info: Info?
    var locations: [Results] = []
    let locationsUrl = "https://rickandmortyapi.com/api/location"

    @IBOutlet weak var locationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressHUD.show(in: self.view)
        getLocationList(url: locationsUrl)
        locationTableView.delegate = self
        locationTableView.dataSource = self
        locationTableView.backgroundColor = .darkGray
        locationTableView.separatorColor = .black
        
        let nib = UINib(nibName: LocationTableViewCell.className, bundle: nil)
        locationTableView.register(nib, forCellReuseIdentifier: LocationTableViewCell.className)
    }
    
    func getLocationList(url: String) {
        networkManager.getLocations(url: url) { [ weak self ] (locationResponse, error) in
            if let error = error {
                AppSnackBar.showMessageSnackBar(in: self?.view, message: error.localizedDescription)
                self?.progressHUD.dismiss()
            }
            self?.info = locationResponse?.info
            guard let locationResponse = locationResponse
            else {
                return
            }
            self?.locations.append(contentsOf: locationResponse.results)
            self?.locationTableView.reloadData()
            self?.progressHUD.dismiss()
        }
    }
}

extension LocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let nextLocations = info?.next
        else {
            return
        }
        if locations.count/2 == indexPath.row {
            getLocationList(url: nextLocations)
        }
    }
    
    func goToResidents(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let residentsViewController = storyboard.instantiateViewController(withIdentifier: "ResidentsViewController") as? ResidentsViewController {
            residentsViewController.title = "Жители локации \"\(locations[indexPath.row].name)\""
            residentsViewController.urlResidentList = locations[indexPath.row].residents
            navigationController?.pushViewController(residentsViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if locations[indexPath.row].residents.count != 0 {
            goToResidents(indexPath: indexPath)
        }
    }
}

extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.className) as? LocationTableViewCell {
            cell.nameLocationLabel.text = locations[indexPath.row].name
            cell.typeLocationLabel.text = locations[indexPath.row].type
            cell.populationLocationLabel.text = "population: \(locations[indexPath.row].residents.count)"
            cell.backgroundColor = .lightGray
            if locations[indexPath.row].residents.count != 0 {
                cell.accessoryType = .disclosureIndicator
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
        return UITableViewCell()
    }
}
