//
//  SearchView.swift
//  MusicX
//
//  Created by Atheer on 2019-10-31.
//  Copyright © 2019 Atheer. All rights reserved.
//

import SwiftUI
import Combine

struct SearchView: View {
    // a state for when search button is tapped
    @State private var isSearching: Bool = false
    // this variable is used to update the view
    // when user enters text into textfiled
    @State private var searchMusic: String = ""
    @ObservedObject var networkManager = NetworkManager()
    @State var Push: Bool = false
    @State var url: String = ""
        
    var body: some View {
        NavigationView {
            VStack {
                searchTextField(isSearching: isSearching, searchMusic: $searchMusic, networkManager: networkManager)
               
                exampleText(isSearching: isSearching)
            
                if self.networkManager.isDataReady {
            GeometryReader { geometry in
                ScrollView {
                    // needed this so we can initalize our scroll otherwise nothing will fucking show up
                    Rectangle()
                        .frame(width: geometry.size.width, height: 0.01)
                    
                        ForEach(self.networkManager.fetchedSongsResults, id: \.title) { song in
                            VStack {
                                SongCardView(push: self.$Push, lyric: self.$url, isSearching: self.isSearching, imageUrl:song.imageUrl, title: song.title ,artist:song.primary_artist.name, LyricUrl: song.lyricsUrl)
                            }
                        }
                }
                .opacity(self.isSearching ? 1 : 0)
                .offset(y: self.isSearching ? -55 : UIScreen.main.bounds.height)
                .animation(.default)
                
            }
                }
                NavigationLink(destination: LyricView(pushed: $Push, url: $url), isActive: $Push) {
                    EmptyView()
                }
            }
            // makings sure navigation view takes the whole space
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.top)
            // adding navigation bar title
            .navigationBarTitle(Text("Search"))
            // adding search button with that toggles the
            // text field
            .navigationBarItems(trailing:
                Button(action: {
                    // when search button is tapped
                    self.isSearching.toggle()
                }) {
                    CustomButton(nameOfImage: "magnifyingglass")
            })
                // added background color for whole view
        .background(Color(UIColor.systemGray5).edgesIgnoringSafeArea(.all))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct searchTextField: View {
    var isSearching: Bool
    @Binding var searchMusic: String
    @ObservedObject var networkManager:NetworkManager
    var body: some View {
        // creating text field and when user commits the text
        // gets to reset
        HStack {
            TextField("Search", text: $searchMusic , onCommit: {
                self.networkManager.fetchSongs(userSearched: self.searchMusic)
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                // when clear button is tapped
                self.networkManager.fetchedSongsResults.removeAll()
                self.searchMusic = ""
                }) {
                    CustomButton(nameOfImage: "xmark.circle")
            }
        }
            .padding(.horizontal, 6)
            .opacity(isSearching ? 1 : 0)
            .offset(x: isSearching ? 0 : -UIScreen.main.bounds.width )
            .shadow(radius: 5)
            .animation(.spring())
        
    }
}
// this view is used to explain to user on how to begin search
struct exampleText: View {
    var isSearching: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text("Press the search button to begin searching for a song")
            HStack {
                Text("Example:")
                Text("Sia - Chandelier")
                    .font(.headline)
                    .fontWeight(.heavy)
            }
        }
        .padding(.horizontal, 8)
        .opacity(isSearching ? 0 : 1)
        .offset(y: UIScreen.main.bounds.height/3)
        .animation(.spring())
    }
}

// the view for song card view
struct SongCardView: View {
    @Binding var push: Bool
    @Binding var lyric: String
    var isSearching: Bool
    var imageUrl: String
    var title: String
    var artist: String
    var LyricUrl: String
   
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            Button(action: {
                self.lyric = self.LyricUrl
                self.push = true
            }) { CustomImageView(withURL: imageUrl) }
            HStack {
                Text(title)
                    .modifier(SongCardViewTextModifier())
                Text("-")
                    .modifier(SongCardViewTextModifier())
                Text(artist)
                    .modifier(SongCardViewTextModifier())
                
            }
            .frame(minWidth: 0, maxWidth: 240, minHeight: 0, maxHeight: 30)
            .background(Color.gray.opacity(0.8))
            .padding()
        }
    }
}
