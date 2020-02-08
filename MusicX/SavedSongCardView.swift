//
//  SavedSongCardView.swift
//  MusicX
//
//  Created by Atheer on 2020-02-06.
//  Copyright © 2020 Atheer. All rights reserved.
//

import SwiftUI

struct SavedSongCardView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: SavedSong.getAllSavedSongs()) var savedSongs: FetchedResults<SavedSong>
    @State var Push: Bool = false
    @State var songLyricsUrl: String = ""
    @State var artistAndTitle: String = ""
    
  
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                if (self.savedSongs.isEmpty) {
                    Text("No Saved Songs")
                } else {
                    ScrollView {
                        ForEach(self.savedSongs) { savedSong in
                            savedSongCard(title: savedSong.title!, artist: savedSong.artist!,lyricsUrl: savedSong.songLyricsUrl!, pushed: self.$Push, url: self.$songLyricsUrl, artistNTitle: self.$artistAndTitle)
                        }
                    }
                    
                    NavigationLink(destination: LyricView(pushed: $Push, url: $songLyricsUrl, artistNTitle: $artistAndTitle), isActive: $Push) {
                        EmptyView()
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.top)
            .navigationBarTitle(Text("Saved Songs"))
        .background(Color(UIColor.systemGray5).edgesIgnoringSafeArea(.all))
            .navigationBarItems(trailing:
                HStack {
                    // only for testing remove later
                  Button(action: {
                   self.managedObjectContext.delete(self.savedSongs.first!)

                       do {
                           try self.managedObjectContext.save()
                       } catch {
                           print(error)
                       }
                     }) {
                         CustomButton(nameOfImage: "trash")
                  }
                }
            )
        }
        
        
    }
}

struct SavedSongCardView_Previews: PreviewProvider {
    static var previews: some View {
        SavedSongCardView()
    }
}

 
