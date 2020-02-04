//
//  savedSongCard.swift
//  MusicX
//
//  Created by Atheer on 2020-02-02.
//  Copyright © 2020 Atheer. All rights reserved.
//

import SwiftUI

struct savedSongCard: View {
    var title: String = ""
    var artist: String = ""
    
    
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.semibold)
            Text(artist)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                
        }
            .padding()
            .border(Color.black)
            .background(Color.gray)
    }
}

//struct savedSongCard_Previews: PreviewProvider {
//    static var previews: some View {
//        savedSongCard()
//    }
//}
