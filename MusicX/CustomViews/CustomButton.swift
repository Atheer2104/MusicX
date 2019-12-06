//
//  CustomButton.swift
//  MusicX
//
//  Created by Atheer on 2019-12-06.
//  Copyright © 2019 Atheer. All rights reserved.
//

import SwiftUI

struct CustomButton: View {
    var nameOfImage: String
    
    var body: some View {
        // creating search button
        Image(systemName: nameOfImage)
            .resizable()
            .padding(10)
            .aspectRatio(contentMode: .fit)
            .frame(width: 44, height: 44)
    }
}
