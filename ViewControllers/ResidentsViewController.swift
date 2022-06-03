//
//  ResidentsViewController.swift
//  hnh1
//
//  Created by Юлия Руднева on 02.06.2022.
//

import UIKit
import JGProgressHUD

class ResidentsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    var urlResidentList: [String] = []
    @IBOutlet weak var collectionResidentsView: UICollectionView!
    let networkManager = ServiceLocator.characterNetworkManager()
    let imageService = ServiceLocator.imageService()
    let progressHUD = JGProgressHUD()
    
    var character: Character?
    var characterList: [Character] = []
    let requestCharacterQueue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionResidentsView.dataSource = self
        let nib = UINib(nibName: ResidentsCollectionViewCell.className, bundle: nil)
        collectionResidentsView.register(nib, forCellWithReuseIdentifier: ResidentsCollectionViewCell.className)
        collectionResidentsView.collectionViewLayout = compositionalLayout
        collectionResidentsView.backgroundColor = .darkGray
    }

    let compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(173),
            heightDimension: .absolute(187))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(187))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(20)
        let spacing: CGFloat = 24
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 28
        section.contentInsets = NSDirectionalEdgeInsets(top: 28, leading: 24, bottom: 28, trailing: 24)
        return UICollectionViewCompositionalLayout(section: section)
    }()

    func requestCharacter(url: String, completion: @escaping (Character) -> ()) {
        self.networkManager.getCharacter(url: url) { [ weak self ] (character, error) in
            if let error = error {
                AppSnackBar.showMessageSnackBar(in: self?.view, message: "\(error.localizedDescription)")
            }
            guard let character = character
            else {
                return
            }
            self?.characterList.append(character)
            completion(character)
        }
    }
}

extension ResidentsViewController: UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         urlResidentList.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResidentsCollectionViewCell.className, for: indexPath) as? ResidentsCollectionViewCell {
             requestCharacter(url: urlResidentList[indexPath.row]) { character in
                 DispatchQueue.main.async {
                    cell.nameResidentLabel.text = character.name
                    cell.genderResidentLabel.text = character.gender.rawValue
                    cell.speciesResidentLabel.text = character.species
                 }
                 DispatchQueue.global().async {
                     self.imageService.getImage(urlString: character.image) { (image) in
                        DispatchQueue.main.async {
                            cell.imageResidentImageView.image = image
                            cell.imageResidentImageView.alpha = 1
                        }
                     }
                 }
             }
             return cell
         }
         return UICollectionViewCell()
     }
}
