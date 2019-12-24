//
//  CustomImageView.swift
//  MusicX
//
//  Created by Atheer on 2019-12-06.
//  Copyright © 2019 Atheer. All rights reserved.
//

import SwiftUI

func imageFromData(_ data:Data) -> UIImage {
    UIImage(data: data) ?? UIImage()
}

struct CustomImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
    
    var body: some View {
        // checking for our fetched is not nil if nil then we just use an empty UIImage
        // if we have fetched our image then we set as our image
        Image(uiImage: imageLoader.dataIsValid ? imageFromData(imageLoader.fetchedImage!) : UIImage())
           .renderingMode(.original)
           .resizable()
           .cornerRadius(30)
           .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.width/1.5)
    }
}
