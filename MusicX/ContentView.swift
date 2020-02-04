//
//  ContentView.swift
//  MusicX
//
//  Created by Atheer on 2019-10-31.
//  Copyright © 2019 Atheer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var idFetcher = YoutubeVideoIDFetcher()
    
    init() {
        self.idFetcher.fetchVideoID(artistAndTitle: "Sia-chandelier")
    }
    
    var body: some View {
        Text(self.idFetcher.videoId)
    }   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
