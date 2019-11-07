//
//  SearchView.swift
//  MusicX
//
//  Created by Atheer on 2019-10-31.
//  Copyright © 2019 Atheer. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State private var isSearching: Bool = false
    @State private var searchMusic: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    searchTextField(isSearching: $isSearching, searchMusic: $searchMusic)
                }
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
                .offset(y: UIScreen.main.bounds.height/3)
            }
            
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.top)
            .navigationBarTitle(Text("Search"))
                
            .navigationBarItems(trailing:
                Button(action: {
                    // when search button is tapped
                    self.isSearching.toggle()
                }) {
                    searchButton()
            })
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
    @Binding var isSearching: Bool
    @Binding var searchMusic: String
    var body: some View {
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
