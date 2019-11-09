//
//  SearchView.swift
//  MusicX
//
//  Created by Atheer on 2019-10-31.
//  Copyright © 2019 Atheer. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    // a state for when search button is tapped
    @State private var isSearching: Bool = false
    // this variable is used to update the view
    // when user enters text into textfiled
    @State private var searchMusic: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    searchTextField(isSearching: isSearching, searchMusic: $searchMusic)
                }
                exampleText(isSearching: isSearching)
                
                SongCardView(isSearching: isSearching)
                
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
                    searchButton()
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

struct searchButton: View {
    var body: some View {
        // creating search button
        Image(systemName: "magnifyingglass")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(10)
            .frame(width: 44, height: 44)
    }
}

struct searchTextField: View {
    var isSearching: Bool
    @Binding var searchMusic: String
    var body: some View {
        // creating text field and when user commits the text
        // gets to reset
        TextField("Search", text: $searchMusic , onCommit: {
            self.searchMusic = ""
        })
            .padding(.horizontal, 13)
            .textFieldStyle(RoundedBorderTextFieldStyle())
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

// this is a custom modifier for the song title
struct songTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.black)
    }
}

// the view for song card view
struct SongCardView: View {
    var isSearching: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("test")
                .resizable()
                .cornerRadius(30)
                .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.width/1.5)
            HStack {
                Text("Chandelier")
                    .modifier(songTitle())
                Text("-")
                    .modifier(songTitle())
                Text("Sia")
                    .modifier(songTitle())
                
            }
            .background(Color.gray.opacity(0.8))
            .padding()
        }
        // Will add proper animation for teh card view
        // this is a simple fix
        .opacity(isSearching ? 1 : 0)
        .animation(.spring())
    }
}
