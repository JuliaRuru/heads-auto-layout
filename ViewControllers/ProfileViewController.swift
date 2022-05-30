//
//  ProfileViewController.swift
//  hnh1
//
//  Created by Юлия Руднева on 28.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let networkManager = ServiceLocator.profileNetworkManager()
    let storageManager = ServiceLocator.profileStorageManager()
    
    @IBOutlet weak var profileTableView: UITableView!
    
    enum ConstantHeightOfCell: Int {
        case standart = 58
        case special = 423
    }
    
    var profile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfile()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.backgroundColor = .darkGray

        let nib1 = UINib(nibName: UserPhotoTableViewCell.className, bundle: nil)
        profileTableView.register(nib1, forCellReuseIdentifier: UserPhotoTableViewCell.className)
        
        let nib2 = UINib(nibName: RegistrationDateTableViewCell.className, bundle: nil)
        profileTableView.register(nib2, forCellReuseIdentifier: RegistrationDateTableViewCell.className)
        
        let nib3 = UINib(nibName: ProfileColorTableViewCell.className, bundle: nil)
        profileTableView.register(nib3, forCellReuseIdentifier: ProfileColorTableViewCell.className)
        
        self.profileTableView.separatorColor = .black
    }
    
    func loadProfile() {
        let userId = storageManager.loadFromKeychain(key: .userId) ?? ""
        networkManager.getProfile(profileId: userId) { [ weak self ] (profile, error) in
            if let error = error {
                AppSnackBar.showMessageSnackBar(in: self?.view, message: error.localizedDescription)
            } else {
                self?.profile = profile
                self?.profileTableView.reloadData()
            }
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = ConstantHeightOfCell.standart.rawValue
        if indexPath.row == 0 {
            height = ConstantHeightOfCell.special.rawValue
        }
        return CGFloat(height)
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = (tableView.dequeueReusableCell(withIdentifier: UserPhotoTableViewCell.className) as? UserPhotoTableViewCell)
            else {
                return UITableViewCell()
            }
            let user = profile?.username
            cell.usernameLabel.text = user
            return cell
        case 1:
            guard let cell = (tableView.dequeueReusableCell(withIdentifier: RegistrationDateTableViewCell.className) as? RegistrationDateTableViewCell)
            else {
                return UITableViewCell()
            }
            return cell
        case 2:
            guard let cell = (tableView.dequeueReusableCell(withIdentifier: ProfileColorTableViewCell.className) as? ProfileColorTableViewCell)
            else {
                return UITableViewCell()
            }
            return cell
        default: break
        }
        return UITableViewCell()
    }
}
