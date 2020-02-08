//
//  TabBar.swift
//  MusicX
//
//  Created by Atheer on 2020-02-06.
//  Copyright © 2020 Atheer. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            SearchView().tabItem({
                VStack {
                    Image(systemName: "magnifyingglass.circle")
                    Text("Search")
                }
                }).tag(0)
            
            SavedSongCardView().tabItem({
                VStack {
                    Image(systemName: "music.note")
                    Text("Saved songs")
                }
                }).tag(1)
            
        }.background(Color(UIColor.systemGray5).edgesIgnoringSafeArea(.all))
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
