//
//  SavedSongCardTextModifier.swift
//  MusicX
//
//  Created by Atheer on 2020-02-08.
//  Copyright © 2020 Atheer. All rights reserved.
//

import SwiftUI

// this is a custom modifier for the songcardview text modifier
struct SavedSongCardTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.black)
            .lineLimit(1)
    }
}
