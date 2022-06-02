//
//  ImageService.swift
//  hnh1
//
//  Created by Юлия Руднева on 01.06.2022.
//

import UIKit

protocol ImageLoadingService {
    func getImage(urlString: String, completion: @escaping (UIImage?) -> ())
}

class ImageService: ImageLoadingService {

    init(networkManager: ImageNetworkManager) {
        self.networkManager = networkManager
    }

    private let networkManager: ImageNetworkManager
    var imageDict: [String: UIImage] = [:]
    let updateQueue = DispatchQueue(label: "ImageServiceQueue")

    func getImage(urlString: String, completion: @escaping (UIImage?) -> ()) {
        if let image = imageDict[urlString] {
            completion(image)
            return
        }
        DispatchQueue.global().async {
            self.networkManager.getImage(urlString: urlString) { [weak self] data, error in
                guard let self = self,
                      error == nil,
                      let data = data
                else {
                    completion(nil)
                    return
            }
                let image = UIImage(data: data)
                self.updateQueue.async { [weak self] in
                    self?.cleanImageDictNeeded()
                    self?.imageDict[urlString] = image
                }
                completion(image)
            }
        }
    }

    private func cleanImageDictNeeded() {
        let allKeys = imageDict.keys
        guard allKeys.count > 50 else {
            return
        }
        let firstKeys = allKeys.prefix(allKeys.count - 50)
        for key in firstKeys {
            imageDict[key] = nil
        }
    }
}
