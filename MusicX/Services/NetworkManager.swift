//
//  NetworkManager.swift
//  MusicX
//
//  Created by Atheer on 2019-11-13.
//  Copyright © 2019 Atheer. All rights reserved.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
      var objectWillChange = PassthroughSubject<NetworkManager, Never>()
      @Published var isDataReady = false
        
        var fetchedSongsResults = [song]() {
            willSet {
                objectWillChange.send(self)
            }
        }
        
        func fetchSongs(userSearched callback: String) {
            guard let url = URL(string: "https://api.genius.com/search?q=\(callback.replacingOccurrences(of: " ", with: "%20"))") else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("Bearer VCc_Cb7o8D_BWda25HM7D1vD7wNtot_HPonFSAZFisqOI2pgop_1drL9AumJQ6GJ", forHTTPHeaderField: "Authorization")

          URLSession.shared.dataTask(with: urlRequest) {data, response, error in
                guard let data = data else { return }
                //print(String(decoding: data, as: UTF8.self))
                let songs = try! JSONDecoder().decode(feed.self, from: data)
                DispatchQueue.main.async {
                    self.fetchedSongsResults = songs.response.hits.map({ $0.result })
                    
                    
                }
            }.resume()
            self.isDataReady = true
        }
    }
