//
//  YoutubeVideoIDFetcher.swift
//  MusicX
//
//  Created by Atheer on 2020-01-28.
//  Copyright © 2020 Atheer. All rights reserved.
//

import Foundation
import Combine

class YoutubeVideoIDFetcher: ObservableObject {
    var objectWillChange = PassthroughSubject<YoutubeVideoIDFetcher, Never>();
    var videoId: String = "" {
        willSet {
            objectWillChange.send(self)
        }
    }
    
    
    func fetchVideoID(GeniusLyricUrl Url:String) {
        if let range = Url.range(of: ".com/") {
             let callback = Url[range.upperBound...].replacingOccurrences(of: "-lyrics", with: "")
            
            guard let urlString = URL(string: "https://www.googleapis.com/youtube/v3/search?part=id&maxResults=1&order=viewCount&q=\(callback)&type=video&key=-") else { return }
                
                
            URLSession.shared.dataTask(with: urlString) {data, response, error in
                guard let data = data else { return }
                
                let feed = try! JSONDecoder().decode(topLevel.self, from: data)
                
                
                DispatchQueue.main.async {
                     guard let id = feed.items.first?.id.videoId else { return }
                     self.videoId = id
                }
            }.resume()
        } else {
            return
        }
    }
}

