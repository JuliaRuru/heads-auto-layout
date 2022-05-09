//
//  ProfileViewController.swift
//  hnh1
//
//  Created by Юлия Руднева on 28.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 58
        if indexPath.row == 0 {
            height = 423
        }
        return CGFloat(height)
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0,
           let cell = tableView.dequeueReusableCell(withIdentifier: UserPhotoTableViewCell.className) as? UserPhotoTableViewCell {
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
            return cell
            }
        if indexPath.row == 1,
           let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationDateTableViewCell.className) as? RegistrationDateTableViewCell {
            return cell
            }
        if indexPath.row == 2,
           let cell = tableView.dequeueReusableCell(withIdentifier: ProfileColorTableViewCell.className) as? ProfileColorTableViewCell {
                return cell
            }
            return UITableViewCell()
    }

}

