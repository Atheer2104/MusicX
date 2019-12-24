//
//  LyricView.swift
//  MusicX
//
//  Created by Atheer on 2019-12-21.
//  Copyright © 2019 Atheer. All rights reserved.
//

import SwiftUI

struct LyricView: View {
    
    @ObservedObject var lyricsFetcher: LyricsFetcher
    @Binding var Push: Bool
    @Binding var songLyricUrl: String
    
    
    init(pushed: Binding<Bool>, url: Binding<String>) {
        //default url for song lyric
        //songLyricUrl = url
        self._Push = pushed
        self._songLyricUrl = url
        
        self.lyricsFetcher = LyricsFetcher()
        self.lyricsFetcher.fetchSongLyric(url: songLyricUrl)
        
    }

    var body: some View {
            VStack {
            if self.lyricsFetcher.isDataReady {
                VStack {
                    ScrollView {
                        ForEach(0..<self.lyricsFetcher.fetchedLyricsArray.count) { index in
                           
                            LyricText(part: self.lyricsFetcher.fetchedLyricsArray[index])
                        }
                    }
                }
            }
            }
            .navigationBarTitle(Text("MusicX"), displayMode: .inline)
.background(Color(UIColor.systemGray5).edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
       .navigationBarItems(leading: BackButton(label: "Back") {
            self.Push = false
        })
        
    }
}

/*struct LyricView_Previews: PreviewProvider {
    static var previews: some View {
        LyricView()
    }
}*/

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

struct BackButton: View {
    let label: String
    let closure: () -> ()

    var body: some View {
        Button(action: { self.closure() }) {
            HStack {
                Image(systemName: "chevron.left")
                Text(label)
            }
        }
    }
}
