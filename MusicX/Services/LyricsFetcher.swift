//
//  LyricsFetcher.swift
//  MusicX
//
//  Created by Atheer on 2019-12-21.
//  Copyright © 2019 Atheer. All rights reserved.
//

import Foundation
import Combine
import SwiftSoup

class LyricsFetcher: ObservableObject {
    @Published var isDataReady = false
    @Published var fetchedLyricsArray = [String.SubSequence]()
    
    func fetchSongLyric(url: String) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
             guard let data = data else {
                   print("data was nil")
                   return
             }
               
            guard let htmlString = String(data: data, encoding: String.Encoding.utf8) else {
                   print("cannot cast data into string")
                   return
             }
            
            DispatchQueue.main.async {
                self.fetchedLyricsArray = self.fetchLyrics(TheHtml: htmlString)
                self.isDataReady = true
            }
            
        }.resume()
        
    }
    
    private func CleanLyric(lyricText text: String) -> [String.SubSequence] {
        let lyricArray = text.split(separator: "[")
        
        return lyricArray
    }
    
    private func fetchLyrics(TheHtml html:String) -> [String.SubSequence]{
        var lyricArray = [String.SubSequence]()
        
        do {
            let body: Document = try SwiftSoup.parseBodyFragment(html)
            let lyricDiv = try body.getElementsByClass("lyrics")
            guard let p:Element = try lyricDiv.select("p").first() else { return lyricArray}
            let uncleanedLyricText: String = try p.text()
            lyricArray = CleanLyric(lyricText: uncleanedLyricText)
       } catch {
           print("error")
       }
        
        return lyricArray
        
        
    }
    
    
    
}
