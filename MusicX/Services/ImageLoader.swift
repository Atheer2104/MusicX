//
//  ImageLoader.swift
//  MusicX
//
//  Created by Atheer on 2019-12-03.
//  Copyright © 2019 Atheer. All rights reserved.
//

import Foundation
import Combine

class ImageLoader: ObservableObject {
    @Published var dataIsValid = false
    var fetchedImage: Data?
       
    init(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataIsValid = true
                self.fetchedImage = data
            }
        }
        task.resume()
    }
}
