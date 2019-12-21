//
//  LyricView.swift
//  MusicX
//
//  Created by Atheer on 2019-12-21.
//  Copyright © 2019 Atheer. All rights reserved.
//

import SwiftUI

struct LyricView: View {
    
    var songLyricUrl: String = "https://genius.com/Sia-chandelier-lyrics"
    let testSongLyricsArray = ["Verse 1] Party girls don\'t get hurt Can\'t feel anything, when will I learn? I push it down, push it down I\'m the one \"for a good time call\" Phone\'s blowin\' up, ringin\' my doorbell I feel the love, feel the love ", "Pre-Chorus] 1 2 3, 1 2 3, drink 1 2 3, 1 2 3, drink 1 2 3, 1 2 3, drink Throw \'em back till I lose count ", "Chorus] I\'m gonna swing from the chandelier From the chandelier I\'m gonna live like tomorrow doesn\'t exist Like it doesn\'t exist I\'m gonna fly like a bird through the night Feel my tears as they dry I\'m gonna swing from the chandelier From the chandelier "]
    @ObservedObject var lyricsFetcher: LyricsFetcher
    
    init(url: String) {
        //default url for song lyric
        songLyricUrl = url
        lyricsFetcher = LyricsFetcher()
        lyricsFetcher.fetchSongLyric(url: songLyricUrl)
    }

    var body: some View {
        NavigationView {
            VStack {
            if self.lyricsFetcher.isDataReady {
                VStack {
                    ScrollView {
                        ForEach(0..<self.lyricsFetcher.fetchedLyricsArray.count) { index in
                           
                            LyricText(part: self.lyricsFetcher.fetchedLyricsArray[index])
                        }
                    }
                }
                .padding(.top, 20)
            }
    
            
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.top)
            .navigationBarTitle("MusicX")
        .background(Color(UIColor.systemGray5).edgesIgnoringSafeArea(.all))
        }
        
    }
}

struct LyricView_Previews: PreviewProvider {
    static var previews: some View {
        LyricView(url: "https://genius.com/Sia-chandelier-lyrics")
    }
}

struct LyricText: View {
    let part: String.SubSequence
    var body: some View {
        Text( "[" + part)
            .fontWeight(.bold)
            .font(.system(size: 22))
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
            
    }
}
