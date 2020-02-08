//
//  savedSongCard.swift
//  MusicX
//
//  Created by Atheer on 2020-02-02.
//  Copyright © 2020 Atheer. All rights reserved.
//

import SwiftUI

struct savedSongCard: View {
    var title: String
    var artist: String
    var lyricsUrl: String
    
    @Binding var Push: Bool
    @Binding var songLyricsUrl: String
    @Binding var artistAndTitle: String
    
    let ColorArray: [String] = ["#247BA0", "#70C1B3", "#B2DBBF", "#F3FFBD", "#FF1654"]
    
    init(title: String, artist: String, lyricsUrl: String, pushed: Binding<Bool>, url: Binding<String>, artistNTitle: Binding<String>) {
           self.title = title
           self.artist = artist
           self.lyricsUrl = lyricsUrl
        
           self._Push = pushed
           self._songLyricsUrl = url
           self._artistAndTitle = artistNTitle
       }

    var body: some View {
        Button(action: {
            self.Push = true
            self.songLyricsUrl = self.lyricsUrl
            self.artistAndTitle = "\(self.artist) - \(self.title)"
        }) {
            HStack {
                Text(title)
                    .modifier(SavedSongCardTextModifier())
                
                Text(artist)
                    .modifier(SavedSongCardTextModifier())
            }
            .frame(width: UIScreen.main.bounds.width/1.5, height: 50)
            .padding()
            .border(Color.black)
            .background(Color(UIColor(hexString: ColorArray.randomElement()!)!))
            .padding(.bottom, 10)
        }
    }
}
extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars = ["F","F"] + chars
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
}
