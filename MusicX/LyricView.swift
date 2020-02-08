//
//  LyricView.swift
//  MusicX
//
//  Created by Atheer on 2019-12-21.
//  Copyright © 2019 Atheer. All rights reserved.
//

import SwiftUI
import CoreData

struct LyricView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: SavedSong.getAllSavedSongs()) var savedSongs: FetchedResults<SavedSong>
    
    @State private var newSavedSong = ""
    
    @ObservedObject var lyricsFetcher = LyricsFetcher()
    @ObservedObject var idFetcher = YoutubeVideoIDFetcher()
    @Binding var Push: Bool
    @Binding var songLyricUrl: String
    @Binding var artistAndTitle: String
    
    init(pushed: Binding<Bool>, url: Binding<String>, artistNTitle: Binding<String>) {
        //default url for song lyric
        //songLyricUrl = url
        self._Push = pushed
        self._songLyricUrl = url
        self._artistAndTitle = artistNTitle
        
        self.lyricsFetcher.fetchSongLyric(url: songLyricUrl)
        self.idFetcher.fetchVideoID(artistAndTitle: artistAndTitle)
    }

    var body: some View {
            VStack {
            if self.lyricsFetcher.isDataReady {
                    ScrollView {
                        ForEach(0..<self.lyricsFetcher.fetchedLyricsArray.count) { index in
                           
                            LyricText(part: self.lyricsFetcher.fetchedLyricsArray[index])
                        }.padding(.top, 30)
                }
                
            } else {
                VStack {
                    Text("Please wait while lyrics are fetching")
                        .font(.headline)
                        .fontWeight(.heavy)
                }
            
                }
            }
            .navigationBarTitle(Text("MusicX"), displayMode: .inline)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .padding()
            .background(Color(UIColor.systemGray5).edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
       .navigationBarItems(leading: BackButton(label: "Back") {
            self.Push = false
        }, trailing: HStack {
            // favorites button
            Button(action: {
                let savedSong = SavedSong(context: self.managedObjectContext)
                
                guard let range = self.artistAndTitle.range(of: "-") else { return }
                
                savedSong.title = String(self.artistAndTitle[range.upperBound...])
                savedSong.artist = String(self.artistAndTitle[self.artistAndTitle.startIndex..<range.lowerBound])
                savedSong.songLyricsUrl = "\(self.songLyricUrl)"
                
                
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error)
                }
                
                self.newSavedSong = ""
                print("added to favorites")
               }) {
                   CustomButton(nameOfImage: "suit.heart")
            }
            
            // play button
            Button(action: {
                UIApplication.shared.open(URL(string: "https://www.youtube.com/watch?v=\(self.idFetcher.videoId)")!, options: [:], completionHandler: nil)
               }) {
                   CustomButton(nameOfImage: "play.rectangle.fill")
            }

       })
        
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
