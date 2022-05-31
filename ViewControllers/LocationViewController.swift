//
//  LocationViewController.swift
//  hnh1
//
//  Created by Юлия Руднева on 30.05.2022.
//

import UIKit
import JGProgressHUD

class LocationViewController: UIViewController {
    
    let networkManager = ServiceLocator.locationNetworkManager()
    let progressHUD = JGProgressHUD()
    var info: Info?
    var locations: [Results] = []

    @IBOutlet weak var locationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocationList()
        locationTableView.delegate = self
        locationTableView.dataSource = self
        
        let nib = UINib(nibName: LocationTableViewCell.className, bundle: nil)
        locationTableView.register(nib, forCellReuseIdentifier: LocationTableViewCell.className)
    }
    
    func getLocationList() {
        progressHUD.show(in: self.view)
        networkManager.getLocations() { [ weak self ] (locationResponse, error) in
            if let error = error {
                AppSnackBar.showMessageSnackBar(in: self?.view, message: error.localizedDescription)
            }
            self?.info = locationResponse?.info
            guard let locations = locationResponse?.results
            else {
                return
            }
            self?.locations.append(contentsOf: locations)
            self?.locationTableView.reloadData()
        }
    }
}

extension LocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let height = 58
//        return CGFloat(height)
        return CGFloat()
    }
}

extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.className) as? LocationTableViewCell {
        let location = locations[indexPath.row]
        cell.locationNameLabel.text = location.name
        cell.locationTypeLabel.text = location.type
        cell.populationLabel.text = "population: \(location.residents.count)"
        return cell
        }
        return UITableViewCell()
    }
    
    
}
