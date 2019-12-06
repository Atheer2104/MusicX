//
//  SongCardViewTextModifier.swift
//  MusicX
//
//  Created by Atheer on 2019-12-06.
//  Copyright © 2019 Atheer. All rights reserved.
//

import SwiftUI

// this is a custom modifier for the songcardview text modifier
struct SongCardViewTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.black)
            .lineLimit(1)
    }
}
